const config = require('../config/secret');
const jwt = require('jsonwebtoken');
const rateLimit = require("express-rate-limit");

const limiter = rateLimit({
    windowMs: 15 * 60 * 1000, // 15 minutes
    max: 100, // 100 requests per IP address
});

module.exports = function (app, passport) {


    // route for logging out
    app.post('/api/logout', function (req, res) {
        const token = req.headers.authorization || req.body.token;
        req.logout();
        // req.session = null;
        // res.clearCookie('TEST');
        // res.clearCookie('TEST.sig');
        res.status(200).json({'success-logout': req.user});
    });

    // route for signing in
    app.get('/ping/oauth2', limiter, passport.authenticate('oauth2', {
        scope: ['openid', 'profile', 'email', 'pingid'],
        pfidpadapterid: "Oauth"
    }));



    app.get('/callback',
        passport.authenticate('oauth2', limiter, {
            failureRedirect: '/sign-in;id=1'
        }),
        async function (req, res) {
            console.log("Callback")
            console.log("token", req.user)
            res.redirect('/');
        });

    app.post('/api/is_logged_in', (req, res) => {
        let userData;
        console.log("req.user:",req.user)
        if(req.user) {
            jwt.verify(req.user, config.secret, (err, decode) => {
                if(err){
                    res.redirect('/sign-in');
                } else {
                    userData = decode;
                }
            })
            console.log("User Data: ",userData)
        }
        let triggerValue = req.isAuthenticated()
        res.status(200).json({trigger: triggerValue, user: userData})
    })
};


