#!/bin/bash

sudo cp /home/ubuntu/distelli.yml /etc/distelli.yml
curl -O https://www.distelli.com/download/client
chmod +x client
./client
sudo distelli agent install -conf /etc/distelli.yml
