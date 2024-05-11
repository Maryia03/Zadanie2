2.Zbudować obrazy kontenera z aplikacją opracowaną w punkcie nr 1, które będą pracował na
architekturach: linux/arm64 oraz linux/amd64 wykorzystując sterownik docker-container.

polecenie:docker buildx build --platform linux/amd64,linux/arm64 --tag xlebapek/zadanie1:app1  --push .