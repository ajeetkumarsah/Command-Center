const env = process.env.NODE_ENV || 'development'
    , passport = require('passport')
    , OAuth2Strategy = require('passport-ping-oauth2').Strategy
    , configAuth = require('../config/pingAuthVar').development
    , db = require("../databaseConnection/sql_connection")
    , config = require('../config/secret')
    , jwt = require('jsonwebtoken')
const {model} = require("../utill");
const util = require("../utill");

module.exports = function () {
    // used to serialize the user for the session
    passport.serializeUser(function (user, done) {
        done(null, user);
    });

    // used to deserialize the user
    passport.deserializeUser(function (user, done) {
        done(null, user);
    });

    passport.use(new OAuth2Strategy({
            authorizationURL: configAuth.authorizationURL,
            tokenURL: configAuth.tokenURL,
            clientID: configAuth.clientID,
            clientSecret: process.env.clientSecret,
            callbackURL: configAuth.callbackURL,
        },
        async function (accessToken, refreshToken, params, profile, done) {
            // let user = await model.pipo_user_metric.findOne({where: {name: profile.sub}, raw: true})
            // console.log(profile,"profile")
            try {

                let data = {
                            name: profile.sub,
                            email: profile.email,

                        }
                let token = jwt.sign(data, config.secret, {expiresIn: '180d'});
                return done(null, token)
                // if(profile['groups'] ){
                //     // let newUser = model.pipo_user_metric.create({ name: profile.sub,email: profile.email,user_role:'',is_admin:false })
                //     let data = {
                //         name: profile.sub,
                //         email: profile.email,
                //
                //     }
                //     let token = jwt.sign(data, config.secret, {expiresIn: '180d'});
                //     return done(null, token);
                // // }else if(user) {
                // //     if (user) {
                // //         let data = {
                // //             id: user.id,
                // //             name: user.name,
                // //             email: user.email,
                // //             user_role: user.user_role,
                // //             is_admin: user.is_admin
                // //         }
                // //         let token = jwt.sign(data, config.secret, {expiresIn: '180d'});
                // //         return done(null, token);
                // //     }
                // } else{
                //     return done(null)
                // }
            } catch (err) {
                console.info(err)
                return done(err);
            }
        }));
};
