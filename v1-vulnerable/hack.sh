#!/bin/bash
#1.we easily enter in conatiner  cause there is a shell and we have root prvileges
docker exec -it app_vulnerable whoami

#2. we can install hacking tools cause  Fs is on writable
docker exec -it app_vulnerable apt-get update && apt-get install -y nmap

#3. we can edit source code whilw running
docker exec -it app_vulnerable sed -i 's/UP/HACKED/g' server.js
