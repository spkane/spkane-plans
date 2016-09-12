# Minecraft Server Spigot

This is a Minecraft Spigot server (spigotmc.org).

## Building

*Note*: Sometimes the tests will fail during building. This is likely an instability introduced by the unusual environment we are building in. Re-running the build often, just works.

## Running

```
hab studio enter
build
hab start spkane/minecraft_server_spigot

# By changing the setting below to true you are indicating your agreement to
# the Minecraft EULA (https://account.mojang.com/documents/minecraft_eula).

echo 'accept_eula = true' | hab config apply --peer 172.17.0.2 minecraft_server_spigot.default 2
```

or

```
hab studio enter
build
hab pkg export docker spkane/minecraft_server_spigot
exit

mkdir -p ${HOME}/mc/data

# By changing the setting below to true you are indicating your agreement to
# the Minecraft EULA (https://account.mojang.com/documents/minecraft_eula).

docker run -e HAB_MINECRAFT_SERVER_SPIGOT='accept_eula=true' -p 25565:25565 -v ${HOME}/mc/data:/hab/svc/minecraft_server_spigot/data spkane/minecraft_server_spigot

# OR copy and edit the default.toml and try this...

docker run -e HAB_MINECRAFT_SERVER_SPIGOT="$(cat ~/habitat/minecraft_server_spigot.toml)" -p 25565:25565 -v ${HOME}/mc/data:/hab/svc/minecraft_server_spigot/data spkane/minecraft_server_spigot
```
