const util = require("../utill")
    , env = process.env.NODE_ENV || 'development'
    , configAuth = require('../config/pingAuthVar')[env]
    , jwt = require('jsonwebtoken')
    , request = require('request')
    , config = require('../config/secret')
    // , access_groups = require('../config/access_groups')
const db = require("../connection/db_connection");
const secretKey = process.env.secretKey;
// const fs = require('fs');
//
// const privateKey = fs.readFileSync('path/to/private-key.pem');


login = async (req, res) => {
    try {
        let {access_token} = req.body;
        let profile;
        let options = {
            method: 'GET',
            url: configAuth.userInfoURL,
            headers:
                {
                    'Postman-Token': '47bff26c-d203-4ee1-a2de-e44edc64edbe',
                    'cache-control': 'no-cache',
                    Authorization: `Bearer ${access_token}`
                }
        };

        request(options, async function (error, response, body) {
            if (error) {
                res.status(500).send({'message': 'something went wrong'})
            }

            if (response.statusCode == 200) {
                let userData = JSON.parse(body)
                let user = await db.Users.findOne({where: {email: userData.Email}})
                if(user){
                    jwt.sign({user}, secretKey, {expiresIn: '30000s'}, (err, token) => {
                        let token_obj = {};
                        token_obj["token"] = token;
                        token_obj["user"] = user;
                        res.send(token_obj);
                    })
                }else {
                    let date = new Date();
                    let obj ={
                        last_login : date,
                        is_superuser : 0,
                        first_name : userData.FirstName,
                        last_name : userData.LastName,
                        email : userData.Email
                    };
                    let Data = await db.Users.create(obj);
                    let resObj = {
                        id:Data.id,
                        first_name: Data.first_name,
                        last_name: Data.last_name,
                        email: Data.email,
                        persona_selected: Data.persona_selected,
                        is_superuser: Data.is_superuser
                    }
                    jwt.sign({Data}, secretKey, {expiresIn: '30000s'}, (err, token) => {
                        let token_obj = {};
                        token_obj["token"] = token;
                        token_obj["user"] = Data;
                        res.status(200).send(token_obj);
                    })
                }
            } else {
                res.status(401).send({'message': 'Invalid access token'});
            }

        });
        // res.setHeader({'content-type': 'application/json'})

    } catch (error) {
        console.log(error)
        return res.status(500).json({
            'success': false,
            message: "Ops! Something went wrong, Server Error !",
            error: error
        })
    }
}

// async function getUserProfileFromAccessToken(access_token, res) {
//
// }

// async function normalLogin(profile, res) {
//     console.log("num", profile, profile.uid)
//     const lowercaseKeys = obj =>
//         Object.keys(obj).reduce((acc, key) => {
//             acc[key.toLowerCase()] = obj[key];
//             return acc;
//         }, {});
//     profile = lowercaseKeys(profile);
//     profile['groups'] = ['GDS-MDPCanteenAdmin'];
//     //to remove
//     console.log('12345',profile);
//     utill.model.User.findOne({
//         where: {email: profile.email, access: true}, defaults: {
//             email: profile.email,
//         }, raw: true, mapToModel: false
//     }).then(async user => {
//         console.log(user);
//         if(user){
//             user.access_group = profile['groups'].filter((value) => {
//                 // return access_groups.includes(value)
//                 return ''
//             })
//             if(user.access_group != null  && user.access_group != undefined) {
//                 let data = {
//                     user_id: user.id,
//                     email: user.email,
//                     access_group: user.access_group,
//                 }
//                 let token = jwt.sign(data, config.secret, {expiresIn: '180d'})
//                 balance_coins = await utill.model.UserWallet.findOne({
//                     where: {user_id: user.id}
//                 })
//                 if (!balance_coins) {
//                     defaultBalanceCoins = await utill.model.UserWallet.create(
//                         {
//                             user_id: user.id,
//                             balance_coins: 0
//                         })
//                 }
//                 res.setHeader('Content-Type', 'application/json');
//                 return res.status(200).json({ success: true, user: user, token: token });
//             }
//         }else {
//             res.status(403).json({'success': false, message: "Access Denied"})
//         }
//
//         // let token = jwt.sign({id: user.id}, config.secret, {
//         //     expiresIn: "90d"// expires in 90 days
//         // });
//         // balance_coins = await util.model.UserWallet.findOne({
//         //     where: {user_id: user.id}
//         // })
//         // if (!balance_coins) {
//         //     defaultBalanceCoins = await util.model.UserWallet.create(
//         //         {
//         //             user_id: user.id,
//         //             balance_coins: 0
//         //         })
//         // }
//     }), (error) => {
//         res.status(500).json({'success': false, message: "Ops! Something went wrong, Server Error !", error: error})
//     }
// }

module.exports = {login}
