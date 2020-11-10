/* 
    Al ejecutar este ejemplo:
        * Probar valores de DEFAULT_TIMEOUT = 10
        * Probar valores de DEFAULT_TIMEOUT = 70
        * Desconectar de la red
*/

const Axios = require('axios');
const CircuitBreaker = require('opossum');

const DEFAULT_TIMEOUT = 100;
const DEFAULT_VALUE = {
    userId: 1,
    id: 1,
    title: 'Default title',
    body: 'Default description'
};

const client = Axios.create({
    baseURL: 'https://jsonplaceholder.typicode.com/',
    timeout: DEFAULT_TIMEOUT
});

async function getPost(id) {
    return await client.get(`/posts/${id}`);
}

const circuitBreakerOptions = {
    timeout: DEFAULT_TIMEOUT,
    errorThresholdPercentage: 30,
    resetTimeout: 5000
};

const circuit = new CircuitBreaker(() => client.get('/posts/2'), circuitBreakerOptions);
circuit.fallback(() => console.log(DEFAULT_VALUE));
circuit.on('success', (result) => console.log(result.data));
circuit.on('failure', (error) => console.log(error.code));
circuit.on('open', () => console.log(`OPEN: El circuit breaker está ABIERTO`));
circuit.on('close', () => console.log(`CLOSE: El circuit breaker está CERRADO`));

var cron = setInterval(timer, 2000);

function timer() {
    (async () => {
        console.log("\n===== Sin usar circuit breaker =====\n");
        try {
            const noCBResult = await getPost(1);
            console.log(noCBResult.data);    
        } catch (err) {
            console.error(err.code);
        }
        console.log("\n===== Usando circuit breaker =====\n");
        circuit.fire();
    })();
}

function stopTimer() {
  clearInterval(cron);
}

setTimeout(() => { stopTimer() }, 60000)