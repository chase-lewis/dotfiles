#!/usr/bin/env bash

lock > /dev/null 2>&1 & 
sleep 1
xset dpms force off
