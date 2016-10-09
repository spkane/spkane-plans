# Minecraft Server Spigot

This is a Minecraft Spigot server [http://spigotmc.org/](http://spigotmc.org/).

## Download

Habitat Plan: [https://github.com/spkane/spkane-plans/tree/master/minecraft_server_spigot](https://github.com/spkane/spkane-plans/tree/master/minecraft_server_spigot)

Docker Container:
[https://hub.docker.com/r/spkane/minecraft_spigot/](https://hub.docker.com/r/spkane/minecraft_spigot/)

## Building

```
hab studio enter
build
hab pkg export docker spkane/minecraft_server_spigot
exit
docker tag spkane/minecraft_server_spigot:latest spkane/minecraft_spigot:latest
```

*Note*: Sometimes the tests will fail during building. This is likely an instability introduced by the unusual environment we are building in. Re-running the build often, just works.

## First Run

```
hab start spkane/minecraft_server_spigot

# DATA DIR=/hab/svc/minecraft_server_spigot/data

# By changing the setting below to true you are indicating your agreement to
# the Minecraft EULA [https://account.mojang.com/documents/minecraft_eula](https://account.mojang.com/documents/minecraft_eula).

echo 'accept_eula = true' | hab config apply --peer 172.17.0.2 minecraft_server_spigot.default 2
```

or

```
mkdir -p ${HOME}/mc/data

# Copy and edit the minecraft_server_spigot.toml below and try this...

docker run -e HAB_MINECRAFT_SERVER_SPIGOT="$(cat ~/habitat/minecraft_server_spigot.toml)" -p 25565:25565 -v ${HOME}/mc/data:/hab/svc/minecraft_server_spigot/data spkane/minecraft_spigot
```

## Debugging

For the Docker container, you can try this:

```
docker run -ti --entrypoint /bin/bash spkane/minecraft_spigot
```

and then poke around in here: ```/hab/pkgs/spkane/minecraft_server_spigot```

## Your Data

You data location can vary, but based on the Docker example above, it would be in ```${HOME}/mc/data```. If you are not using a container, the data will be in ```/hab/svc/minecraft_server_spigot/data```.

### Plugins

You can drop Spigot compatible plugins (which include many Bukkit plugins) into the ```plugins``` directory in your data directory and then restart the server.

Plugins: [https://www.spigotmc.org/resources/](https://www.spigotmc.org/resources/)

Some Suggestions for starters:

* EssentialsX: [https://www.spigotmc.org/resources/essentialsx.9089/](https://www.spigotmc.org/resources/essentialsx.9089/)
* Send commands to the Minecraft Server Console: [https://www.spigotmc.org/resources/console-sender.14157/](https://www.spigotmc.org/resources/console-sender.14157/)

## Configuration

At the moment Habitat only controls/overwrites ```eula.txt```, ```server.properties```, and ```ops.json```.

You can change anything else by hand. This may change.

## Example minecraft_server_spigot.toml

*Note*: At a minimum you need to change ```accept_eula``` to ```true``` and change ```usernames``` under ```[ops]``` to include only your username, and trusted friends.

By changing the ```accept_eula``` setting below to ```true``` you are indicating your agreement to the Minecraft EULA [https://account.mojang.com/documents/minecraft_eula](https://account.mojang.com/documents/minecraft_eula).

```
java_xms = "1024M"
java_xmx = "2048M"
accept_eula = false

[server]
max-tick-time = 60000
generator-settings = ""
force-gamemode = false
allow-nether = true
gamemode = 0
enable-query = false
player-idle-timeout = 0
difficulty = 1
spawn-monsters = true
op-permission-level = 4
announce-player-achievements = true
pvp = true
snooper-enabled = true
level-type = "DEFAULT"
hardcore = false
enable-command-block = false
max-players = 20
network-compression-threshold = 256
resource-pack-sha1 = ""
max-world-size = 29999984
server-port = 25565
server-ip = ""
spawn-npcs = true
allow-flight = false
level-name = "world"
view-distance = 10
resource-pack = ""
spawn-animals = true
white-list = false
generate-structures = true
online-mode = true
max-build-height = 256
level-seed = ""
use-native-transport = true
enable-rcon = false
rcon-password = "ch@ng3m3"
rcon-port = 25575
motd = "A Minecraft Server running on Chef Habitat (http://habitat.sh/)"

[ops]
usernames = [ "spkane", "notch" ]
```

