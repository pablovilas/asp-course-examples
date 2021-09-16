const fastify = require('fastify')({ logger: true });
const cron = require('node-cron');
var TASK_ID = 1;


const taskId = () => {
    return TASK_ID++;
};

const longRunningTask = (ms) => {
    // Simulate long running task
    return new Promise(resolve => setTimeout(resolve, ms));
};

//
// Scheduled & Background job
//

const schedule = (task, schedule, delay) => {
    cron.schedule(schedule, () => {
        (async () => { 
            await longRunningTask(delay); 
            fastify.log.info(`Task ${task} finished`);
        })();
        fastify.log.info(`Running task ${task} with schedule ${schedule} and delay ${delay}`);
    });
};

//
// Request/Response - Background job
//

fastify.get('/task', async (request, reply) => {
    let delay = parseInt(request.query.delay) || 0;
    let task = taskId();
    let sync = request.query.sync == 'true';
    if (sync) {
        await longRunningTask(delay);
        fastify.log.info(`Task ${TASK_ID} finished sync`);
    } else {
        longRunningTask(delay);
        fastify.log.info(`Task ${TASK_ID} finished async`);
    }
    return { task: task, delay: delay, sync: sync };
});

// http://localhost:3000/cron?delay=3000&schedule=*/2 * * * * *

fastify.get('/cron', async (request, reply) => {
    let cron = request.query.schedule || '* * * * *';
    let delay = request.query.delay || 0;
    let task = taskId();
    schedule(task, cron, delay);
    return { task: task, delay: delay, schedule: cron };
});

const start = async () => {
  try {
    await fastify.listen(3000);
  } catch (err) {
    fastify.log.error(err);
    process.exit(1);
  }
};
start();