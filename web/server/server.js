const Koa = require('koa');
const { users } = require('./routes/users');
const bodyParser = require('koa-bodyparser');
const mysql = require('mysql2/promise');
const mount = require('koa-mount');
const path = require('path');
const serve = require('koa-static');
const sendFile = require('koa-send');

const PORT = process.env.PORT || 3000;
const STATIC_FILES_PATH = path.join(__dirname, 'build');

async function main() {
    const server = new Koa();
    const authDbConn = await mysql.createConnection({
        host: 'localhost',
        user: 'acore',
        password: 'acore',
        database: 'acore_auth'
    });

    server.use(getLoggerMiddleware());

    const websiteApp = getWebsiteApp();
    const apiApp = await getApiApp(authDbConn);

    const routes = {
        // add your top level routes here.
        '/api': apiApp,
        '/': websiteApp
    }

    const rootLevelRoutes = new Set();
    for (const [route, app] of Object.entries(routes)) {
        server.use(mount(route, app));
        rootLevelRoutes.add(route);
    }

    // add support for client side routing
    server.use(async function(ctx, next) {
        const reqPath = path.parse(ctx.request.url);
        if (ctx.accepts('html') && !rootLevelRoutes.has(reqPath)) {
            await sendFile(ctx, 'index.html', { root: STATIC_FILES_PATH })
        }
        await next();
    });

    server.listen(PORT, () => {
        console.log(`Server up and running on port: ${PORT}`)
    });;


    setInterval(() => {
        // ping mysql to alive
        authDbConn.query(`SELECT NOW();`)
            .then(() => {
                console.log(new Date() + ' pinged mysql to keep conn alive');
            });
    }, 1000 * 60 * 60);

}

main()
    .catch(ex => {
        console.error('application terminated due to an unexpected exception.');
        console.error(ex);
    });

function getLoggerMiddleware() {
    const uniqueIps = new Set();

    return async function(ctx, next) {
        // logger middleware
        const start = new Date();
        await next();
        const end = new Date();
        console.log(`[${ctx.request.ip}]: ${ctx.request.method} ${ctx.request.url} took ${(end - start)}ms`);
    };
}

async function getApiApp(authDbConn) {
    const app = new Koa();

    app.use(async function(ctx, next) {
        ctx.db = { auth: authDbConn };
        await next();
    });
    app.use(bodyParser());
    app.use(users.routes());
    return app;
}

function getWebsiteApp() {
    const app = new Koa();
    app.use(serve(STATIC_FILES_PATH));
    return app;
}