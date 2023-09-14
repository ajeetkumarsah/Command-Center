    const definition = {
    openapi: '3.0.0',
    info: {
        title: 'APIs for Demo Dashboard',
        version: '2.0.0',
        description: 'APIs for Production',
    },
    servers: [
        {
            url: '',
            description: 'Production server',
        }
    ],
    tags: [
        {
            name: "userAPIs",
            description: "User",
            externalDocs: {
                description: "Expand",
                url: ""
            }
        }
    ],
    components: {
        securitySchemes: {
            jwt: {
                type: "http",
                scheme: "bearer",
                in: "header",
                bearerFormat: "JWT"
            },
        }
    }
}
let iconUI = {
    customSiteTitle: "APIs Doc Portal 2.0",
    swaggerOptions: {
        docExpansion: 'none'
    },
    customCssUrl: '/static/custom.css',
    customfavIcon: "/static/favicon.ico"
};

module.exports = {iconUI, definition}
