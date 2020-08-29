const Router = require('koa-router');
const WeightController = require('./weightController');

const router = new Router();
const weight = new WeightController();

router.get('/weights', (ctx, next) => weight.list(ctx, next));
router.post('/weights', (ctx, next) => weight.save(ctx, next));
router.get('/weights/:id', (ctx, next) => weight.fetch(ctx, next));

module.exports = router;