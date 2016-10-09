#!/bin/bash
# Script to generator a valid operator json file for Minecraft

# Inspired by:
# https://msftstack.wordpress.com/2015/09/28/bash-script-to-convert-a-minecraft-username-to-uuid/

# Arguments: a list of space seperated usernames

BODY="["
USERS=( $@ )
UUID_URL=https://api.mojang.com/users/profiles/minecraft

for username in "${USERS[@]}"; do
  CURL="curl -s"
  RESULT=$(${CURL} ${UUID_URL}/${username})
  rawUUID=${RESULT:7:32}
  UUID=${rawUUID:0:8}-${rawUUID:8:4}-${rawUUID:12:4}-${rawUUID:16:4}-${rawUUID:20:12}
  BODY="${BODY}{\"uuid\":\"${UUID}\",\"name\":\"${username}\",\"level\": 4,\"bypassesPlayerLimit\": true},"
done

if [ ${#BODY} -gt 1 ]; then
  FINAL="${BODY%?}]"
else
  FINAL="${BODY}]"
fi

echo ${FINAL}
