Sprawozdanie z zadania 1

Punkt 1:Implementacja serwera
Kod serwera w języku JavaScript
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

Punkt 2:Dockerfile
FROM node
#Autor
LABEL author="Maryia Sialkovich"
#Kopiowanie plików aplikacji do kontenera
COPY server.js /server.js
COPY package.json /package.json
COPY package-lock.json /package-lock.json
#Zależności aplikacji
RUN npm install
#PORT 8080
EXPOSE 8080
#Uruchomienie aplikacji
CMD ["node", "server.js"]

Punkt 3:Polecenia
a.zbudowania opracowanego obrazu kontenera
docker build -t app1(nazwa obrazu) .
b.uruchomienia kontenera na podstawie zbudowanego obrazu
docker run -p 8080:8080 app1
c.sposobu uzyskania informacji, które wygenerował serwer w trakcie uruchamiana kontenera
docker logs laughing_mclaren(nazwa kontenera)
d.sprawdzenia, ile warstw posiada zbudowany obraz.
docker history app1