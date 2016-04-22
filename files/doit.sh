#!/bin/bash

sudo cp /home/ubuntu/distelli.yml /etc/distelli.yml
# wget must have --quiet switch
# curl does not need -s switch 
wget --quiet https://www.distelli.com/download/client
chmod +x client
./client
sudo distelli agent install -conf /etc/distelli.yml
