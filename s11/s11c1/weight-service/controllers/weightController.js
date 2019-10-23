const WeightService = require('../services/weightService');

module.exports = class WeightController {
    constructor() {
        this.weightService = new WeightService();
    }
    async list (ctx, next) {
        let limit = parseInt(ctx.query.limit) || 100;
        let offset = parseInt(ctx.query.offset) || 0;
        let list = (await this.weightService.findAll(limit, offset)) || [];
        ctx.body = { offset: offset, limit: limit, size: list.length, data: list };
        await next();
    }
    async save (ctx, next) {
        let data = ctx.request.body;
        let user = await this.weightService.save(data);
        if (user) {
            ctx.body = user;
        } else {
            ctx.status = 400;
            ctx.body = { status: 400, message: `Invalid Weight data` };
        }
        await next();
    }
    async fetch (ctx, next) {
        let id = ctx.params.id;
        let user = await this.weightService.findById(id);
        if (user) {
            ctx.body = user;
        } else {
            ctx.status = 404;
            ctx.body = { status: 404, message: `Weight #${id} not found` };
        }
        await next();
    }
}