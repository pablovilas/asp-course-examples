const express = require('express');
const fs = require('fs');

const PORT = process.env.PORT || 8080;
const HOST = '0.0.0.0';

const app = express();
app.get('/', (req, res) => {
  res.set('Content-Type', 'text/html');
  res.sendFile(`${__dirname}/static/index.html`);
});

app.get('/no-cache/:id', (req, res) => {
  let stream = fs.createReadStream(`./static/${req.params.id}.jpg`);
  stream.on('open', function () {
    res.set('Content-Type', 'image/jpeg');
    stream.pipe(res);
  });
});

app.get('/cache/:id', (req, res) => {
  let stream = fs.createReadStream(`./static/${req.params.id}.jpg`);
  stream.on('open', function () {
    res.set('Content-Type', 'image/jpeg');
    res.set('Cache-Control', 'private, max-age=3600'); // Only for end user, 1 hour cache
    stream.pipe(res);
  });
});

app.listen(PORT, HOST);
console.log(`Running on http://${HOST}:${PORT}`);