#!/bin/bash

echo "SSID:     $(netctl-auto list | grep -Po '\* wlp58s0-\K.*')"
echo "Internal: $(ip address show wlp58s0 | grep -Po 'inet \K[\d.]+')"
echo "External: $(wget https://api.ipify.org -O - -q)"
