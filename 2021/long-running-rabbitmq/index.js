const fastify = require('fastify')({ logger: true });
const amqp = require('amqplib');
var TASK_ID = 1;

const taskId = () => {
    return TASK_ID++;
};

const longRunningTask = (ms) => {
    // Simulate long running task
    return new Promise(resolve => setTimeout(resolve, ms));
};

((async () => {
    const queue = 'task-queue';
    const connection = await amqp.connect('amqps://gdbdujmv:q25A6GqE4yKnzcbMXH7HpRFILIwyy8Tt@cattle.rmq2.cloudamqp.com/gdbdujmv');
    const channel = await connection.createChannel();

    //
    // Request/Response - Background job
    //

    fastify.get('/task', async (request, reply) => {
        let delay = parseInt(request.query.delay) || 0;
        let response = { task: taskId(), delay: delay };
        channel.sendToQueue(queue, Buffer.from(JSON.stringify(response)));
        return response;
    });

    channel.consume(queue, (msg) => {
        if (msg !== null) {
          let message = JSON.parse(msg.content.toString());
          longRunningTask(message.delay).then(() => {
            fastify.log.info(`Task ${message.task} finished async`);
            channel.ack(msg);
          });
        }
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
})());