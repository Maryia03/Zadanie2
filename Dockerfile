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

