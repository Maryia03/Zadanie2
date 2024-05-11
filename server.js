const http = require('http');
const url = require('url');
const moment = require('moment-timezone');
//Parametry serwera
const PORT = 8080;
const KLIENT_NAME = "Maryia Sialkovcih";
//Obsługa HTTP
const server = http.createServer((req, res) => {
    //Adres IP klienta
    const clientIP = req.connection.remoteAddress;
    //Datę i godzinę klienta
    const clientTime = moment().tz(moment.tz.guess()).format('YYYY-MM-DD HH:mm:ss');
    //Odpowiedź HTML
    const htmlResponse = `
        <html><body>
        <h1>Informacje o kliencie</h1>
        <p>Adres IP klienta: ${clientIP}</p>
        <p>Data i godzina w strefie czasowej klienta: ${clientTime}</p>
        </body></html>
    `;
    //Nagłówki odpowiedzi
    res.writeHead(200, {'Content-Type': 'text/html'});
    //Wysłanie odpowiedzi HTML
    res.end(htmlResponse);
});

//Uruchomienie serwera
server.listen(PORT, () => {
    console.log(`Serwer uruchomiony przez ${KLIENT_NAME} na porcie ${PORT}.`);
});
