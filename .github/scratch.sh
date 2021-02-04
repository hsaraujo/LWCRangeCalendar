#!/bin/bash

mkdir -p /tmp/keys
echo ${{ secrets.DEVHUB_SERVER_KEY }} >/tmp/keys/server64.key
base64 -d /tmp/keys/server64.key >/tmp/keys/server.key
cat /tmp/keys/server.key
sfdx force:auth:jwt:grant --clientid ${{ secrets.DEVHUB_CLIENT_ID }} --jwtkeyfile /tmp/keys/server.key --username heitor.saraujo@gmail.com.dev --instanceurl https://login.salesforce.com -a DEV_HUB
sfdx force:org:create -f config/project-scratch-def.json -v DEV_HUB -t scratch --setdefaultusername -d 1
sfdx force:source:push