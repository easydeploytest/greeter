const http = require('http');

const PORT = process.env.PORT || 3000;
const APP = process.env.OTEL_SERVICE_NAME || 'my-app';
const ENV = process.env.DEPLOYMENT_ENV || process.env.NODE_ENV || 'dev';
const GREETING = process.env.GREETING || 'Hello from EasyDeploy!';

const server = http.createServer((req, res) => {
  if (req.url === '/healthz') {
    res.writeHead(200, { 'Content-Type': 'application/json' });
    res.end(JSON.stringify({ status: 'ok' }));
    return;
  }

  res.writeHead(200, { 'Content-Type': 'application/json' });
  res.end(JSON.stringify({
    app: APP,
    env: ENV,
    message: GREETING,
    time: new Date().toISOString(),
  }));
});

server.listen(PORT, () => {
  console.log(`${APP} listening on :${PORT} (env: ${ENV})`);
});
