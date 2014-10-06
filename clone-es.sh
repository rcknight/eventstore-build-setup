#!/usr/bin/env bash

#add github to known hosts file
touch ~/.ssh/known_hosts 
ssh-keyscan -H github.com > ~/.ssh/known_hosts 
chmod 600 ~/.ssh/known_hosts

git clone --recursive git@github.com:EventStore/EventStore.git