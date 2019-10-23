const Server = require('./server');
const Repository = require('./repositories/repository');

(async () => {
    try {
        await Repository.initRepository();
        await Server.init();
        console.log('Server started');
    } catch(err) {
        console.log(`Error initializing server: ${err}`);
        process.exit(1);
    }
})();