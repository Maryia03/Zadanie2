#Ustawienie obrazu bazowego jako 'scratch'
FROM scratch as builder
#Dodawanie zawartości Alpine do obrazu
ADD alpine-minirootfs-3.20.0-x86_64.tar.gz /
#Autor
LABEL author="Maryia Sialkovich"
#Dodawanie git
RUN apk add git
#Kopiowanie repozytorium z GitHuba za pomocą git i ustawienie uprawnień dla użytkownika 'node'
RUN --mount=type=ssh git clone https://github.com/Maryia03/Zadanie-1 && \
    addgroup -S node && \
    adduser -S node -G node && \
    rm -rf /var/cache/apk
#Ustawienie użytkownika 'node' jako domyślnego użytkownika
USER node
WORKDIR /home/node/app
#Kopiowanie pliku 'server.js' do katalogu roboczego
COPY --chown=node:node server.js .

#Ustawienie obrazu bazowego jako 'node:iron-alpine3.20'
FROM node:iron-alpine3.20
#Instalacja git i curl
RUN apk add --no-cache git && \ 
    apk update && \
    apk upgrade && \
    apk add --no-cache curl
USER node
#Utworzenie katalogu '/home/node/app' 
RUN mkdir -p /home/node/app
WORKDIR /home/node/app
#Skopiowanie pliku 'server.js' do katalogu roboczego
COPY --from=builder --chown=node:node /home/node/app/server.js ./server.js
#PORT 8080
EXPOSE 8080
#Konfiguracja testu stanu aplikacji
HEALTHCHECK --interval=4s --timeout=20s --start-period=2s --retries=3 \
    CMD curl -f http://localhost:8080/ || exit 1
#Uruchomienie aplikacji
ENTRYPOINT ["node", "server.js"]

