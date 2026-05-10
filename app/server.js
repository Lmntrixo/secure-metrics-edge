const http = require('http');
const fs = require('fs');

const PORT = 3000;
const LOG_FILE = '/app/logs/access.log';

const server = http.createServer((req, res) => {
	//log de l'acces
	const logEntry = `${new Date().toISOString()} - ${req.method} ${req.url}\n`;

	// tentative d'ecriture (echouera si mal configure en read-only)
	fs.appendFile(LOG_FILE, logEntry, (err) => {
		if (err) console.error("Erreur Log", err.message);
	});

	if (req.url === '/health') {
		res.writeHead(200, { 'content-Type': 'application/json' });
		res.end(JSON.stringify({ status: 'UP', timestamp: new Date() }));
	} else {
		res.writeHead(404);
		res.end();
	}
});

 server.listen(PORT, () => {
	console.log(`Serveur securise sur le port ${PORT}`);
});
