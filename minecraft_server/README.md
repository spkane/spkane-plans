# Minecraft Server Vanilla

This is a vanilla Minecraft server (https://minecraft.net/).


```
hab studio enter
build
hab start spkane/minecraft_server

# By changing the setting below to true you are indicating your agreement to
# the Minecraft EULA (https://account.mojang.com/documents/minecraft_eula).

echo 'accept_eula = true' | hab config apply --peer 172.17.0.2 minecraft_server.default 2
```

or

```
hab studio enter
build
hab pkg export docker spkane/minecraft_server
exit

mkdir -p ${HOME}/mc/data

# By changing the setting below to true you are indicating your agreement to
# the Minecraft EULA (https://account.mojang.com/documents/minecraft_eula).

docker run -e HAB_MINECRAFT_SERVER='accept_eula=true' -p 25565:25565 -v ${HOME}/mc/data:/hab/svc/minecraft_server/data spkane/minecraft_server

# OR copy and edit the default.toml and try this...

docker run -e HAB_MINECRAFT_SERVER="$(cat ~/habitat/minecraft_server.toml)" -p 25565:25565 -v ${HOME}/mc/data:/hab/svc/minecraft_server/data spkane/minecraft_server
```
