module.exports.init = function () {
    const Config = require('config');
    const Koa = require('koa');
    const logger = require('koa-logger');
    const json = require('koa-json');
    const bodyParser = require('koa-bodyparser');
    const router = require('./controllers/router');
    const argv = require('minimist')(process.argv.slice(2));
    
    const app = new Koa();
    const port = argv.port ? parseInt(argv.port) : 8080;
    
    app.use(logger());
    app.use(bodyParser());
    app.use(json());
    app.use(router.routes());
    app.use(router.allowedMethods());
    return app.listen(port);
}