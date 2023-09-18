const express = require("express");
const app = express();
const port = process.env.PORT || 3000;
// require('./build/build/web/index.html')
modelInit = require("./models-init/models-init")
const rateLimit = require('express-rate-limit');
const helmet= require('helmet');
// Apply rate limiting to a specific endpoint
const limiter = rateLimit({
    windowMs: 15 * 60 * 1000, // 15 minutes
    max: 100, // 100 requests per IP address
});

const csrf = require('csurf');
const cookieParser = require('cookie-parser');

// Use cookieParser middleware to parse cookies
app.use(cookieParser());

// Enable CSRF protection
const csrfProtection = csrf({ cookie: true });
app.use(csrfProtection);

// Add a middleware to set the CSRF token in the response locals
app.use((req, res, next) => {
    res.locals.csrfToken = req.csrfToken();
    next();
});

// Your routes and other middleware go here

// Error handler for CSRF token validation failures
app.use((err, req, res, next) => {
    if (err && err.code === 'EBADCSRFTOKEN') {
        res.status(403).send('CSRF token validation failed');
    } else {
        next(err);
    }
});


const docSwag = require('./api-doc/definition'),
    swaggerUi = require('swagger-ui-express'),
    cors = require("cors"),
    swaggerJsdoc = require('swagger-jsdoc'),
    bodyParser = require("body-parser")
    ,passport = require('passport')
    , flash = require('connect-flash'),
    log4js = require('log4js')
    , session = require('express-session')
    , cookieSession = require('cookie-session')
    , secretConf = require('./config/secret'),
    compression = require('compression');

app.use(express.json());
let definition = docSwag.definition

const options = {
    definition,
    apis: ['./router/*.js'],
}
const swaggerSpec = swaggerJsdoc(options);
let swaggerHtmlV1 = swaggerUi.generateHTML(swaggerSpec, docSwag.iconUI)

app.use(limiter);
app.use(helmet());

app.use('/api-docs', swaggerUi.serveFiles(swaggerSpec, docSwag.iconUI))
app.get('/api-docs', (req, res) => {
    res.send(swaggerHtmlV1)
});
const log = log4js.getLogger("app");
const path = require("path");
app.use(cors());
app.use(bodyParser.json({limit: '5072mb'}));
app.use(bodyParser.urlencoded({limit: '5072mb', 'extended': 'true'}));
app.use(bodyParser.json({type: 'application/vnd.api+json'}));
app.use('/static', express.static(path.join(__dirname, 'public')))
app.use(compression());
app.use(cookieSession({
    maxAge: 60 * 60 * 1000 * 24,
    keys: ['xyz']
}))
app.use(session({
    secret: secretConf.secret, resave: true, saveUninitialized: true
    , cookie: {
        secure: false,
        httpOnly: true,
        domain: 'localhost:4200',
    }
}));
// app.use(express.static(path.join(__dirname, './build/build/web')));


// modelInit.utils(db).then(r => console.log("Table initialize successfully"))
require('./pingFiles/ping-auth')(passport);
app.use(passport.initialize());
app.use(passport.session());
app.use(flash());

require('./pingFiles/routes')(app, passport);

app.use(flash());

// app.use('/doc', swaggerUi.serve, swaggerUi.setup(swaggerFile))

require('./router/routes')(app);
app.use(express.static( './build/build/web'));

app.use((req, res) => {
    res.sendFile(path.join(__dirname + '/build/build/web/index.html'), limiter);
});

// app.use(express.static(dir));

// app.get('/home', (req, res) => {
//     res.sendFile(path.join(__dirname, '/build/build/web/index.html'));
// });
// app.use(compression());

// require('./router/routes')(app);

app.listen(port, () => {
    console.log("Hello I am here on Port", port);
});
