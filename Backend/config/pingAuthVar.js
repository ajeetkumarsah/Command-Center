module.exports = {
  //local
  // "development": {
  //   authorizationURL: 'https://fedauthtst.pg.com/as/authorization.oauth2',
  //   tokenURL: 'https://fedauthtst.pg.com/as/token.oauth2',
  //   clientID: 'Tasty Bites Ahmedabad',
  //   clientSecret: 'kP69QWMPeEPJ0OPBXqY6X8isXpmz8e8GPbVDdVp1kce5zcMFyo1uFOSIVz6Z0xcC',
  //   callbackURL: 'https://webcanteen-webmwy-dev-cantn.azurewebsites.net/callback',
  //   // callbackURL: 'http://localhost:3000/callback',
  //   userInfoURL:'https://fedauthtst.pg.com/idp/userinfo.openid'
  // },

  "development": {
    authorizationURL: 'https://fedauthtst.pg.com/as/authorization.oauth2',
    tokenURL: 'https://fedauthtst.pg.com/as/token.oauth2',
    clientID: 'Command Center',
    // callbackURL: 'https://ahmcanteen-webcqu-prod.azurewebsites.net/callback',
    // callbackURL: 'http://localhost:3000/callback',
    callbackURL: 'https://cmndcntr-web-dev-web01.azurewebsites.net/callback',

    userInfoURL:'https://fedauthtst.pg.com/idp/userinfo.openid'
  },

  // "development": {
  //   authorizationURL: process.env.PING_AUTHORIZATION_URL,
  //   tokenURL: process.env.PING_TOKEN_URL,
  //   clientID: process.env.PING_CLIENT_ID,
  //   clientSecret: process.env.PING_CLIENT_SECRET,
  //   callbackURL: process.env.PING_CALLBACK_URL,
  //   callbackURL2: process.env.PING_CALLBACK_URL2,
  //   userInfoURL:process.env.PING_USERINFO_IDP
  // },
  "stage": {
    authorizationURL: process.env.PING_AUTHORIZATION_URL,
    tokenURL: process.env.PING_TOKEN_URL,
    clientID: process.env.PING_CLIENT_ID,
    clientSecret: process.env.PING_CLIENT_SECRET,
    callbackURL: process.env.PING_CALLBACK_URL,
    callbackURL2: process.env.PING_CALLBACK_URL2,
    userInfoURL:process.env.PING_USERINFO_IDP
  },
  "production": {
    authorizationURL: process.env.PING_AUTHORIZATION_URL,
    tokenURL: process.env.PING_TOKEN_URL,
    clientID: process.env.PING_CLIENT_ID,
    clientSecret: process.env.PING_CLIENT_SECRET,
    callbackURL: process.env.PING_CALLBACK_URL,
    callbackURL2: process.env.PING_CALLBACK_URL2,
    userInfoURL:process.env.PING_USERINFO_IDP
  }
};
