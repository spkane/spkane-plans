#Minecraft


```
hab start spkane/minecraft_server

# By changing the setting below to true you are indicating your agreement to
# the Minecraft EULA (https://account.mojang.com/documents/minecraft_eula).

echo 'accept_eula = true' | hab config apply --peer 172.17.0.2 minecraft_server.default 2
```
