const db = require("../connection/db_connection");
const jwt = require("jsonwebtoken");
const secretKey = process.env.secretKey;
// const secretKey = process.env.secretKey;

let loginUser = async (req, res) =>{
    let userData = await db.Users.findOne({where: {email: req.body.email},
        attributes: ["id","first_name","last_name", "email", "is_superuser"]});
    if(userData){
        // console.log('userData.........', userData);
        jwt.sign({userData}, secretKey, {expiresIn: '30000s'}, (err, token) => {
            let token_obj = {};
            token_obj["access"] = token;
            token_obj["refresh"] = token;
            token_obj["user"] = userData;
            res.send(token_obj);
        })
        // TODO domain_type, access_token, refresh_token is to be added
        // res.send({message:"existing user", data: userData})
    }
    else{
        addUser(req, res);
    }
}

async function addUser (req, res) {
    // console.log("Add user invoked.....", req);
    let date = new Date();
    try {
        let obj ={
            last_login : date,
            is_superuser : 0,
            first_name : req.body.first_name,
            last_name : req.body.last_name,
            email : req.body.email
        };
        let Data = await db.Users.create(obj);
        let resObj = {
            id:Data.id,
            first_name: Data.first_name,
            last_name: Data.last_name,
            email: Data.email,
            persona_selected: Data.persona_selected,
            is_superuser: Data.is_superuser,
            is_tour_taken: Data.is_tour_taken,
        }
        // TODO domain_type access_token, refresh_token is to be added
        res.status(200).json({ data: resObj, success: "Success", message: "New User Added" });
    } catch (err) {
        console.log('e',err);
        res.status(500).json({ message: 'Something went wrong while uploading User data', error: err });
    }

}

async function verifyToken (req, res) {
    // console.log("Verifying Token....",req.headers )
    // console.log("Verifying Token....",req.headers.authorization )
    const bearerHeader = req.headers.authorization;
    // const bearerHeader = req.query.Authorization;
    if(typeof bearerHeader !== "undefined"){
        req.token = bearerHeader;
    }
    else {
        console.log("Invalid Token");
        // res.send({result:"Invalid Token"})
    }
}

let userProfile = async (req, res) => {
    try{
        await verifyToken(req, res);
        jwt.verify(req.token, secretKey, (err, authData) => {
            if(err){
                res.send({result:"Invalid Token"});
            }else {
                let userData = authData.userData
                jwt.sign({userData}, secretKey, {expiresIn: '30000s'}, (err, token) => {
                    let token_obj = {};
                    token_obj["access"] = token;
                    token_obj["refresh"] = token;
                    token_obj["user"] = userData;
                    res.send(token_obj);
                })
                // res.send({message: "Profile accessed", data: authData})
                // res.locals.authenticated = { 'role': 'user', 'user': user };
            }
        });
    }
    catch (err){
        console.log("Error", err);
        res.status(500).json({ message: 'Something went wrong while uploading User data', error: err });
    }

}


module.exports = { loginUser, userProfile };
