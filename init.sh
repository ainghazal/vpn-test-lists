#!/bin/sh
HOME=/home/probe
USER=probe
adduser $USER
mkdir -p $HOME/ooni/oonirun
mkdir -p $HOME/ooni/privaterun
mkdir -p $HOME/ooni/store
mkdir -p $HOME/.miniooni/vpn
mkdir -p $HOME/.ssh
chown -R $USER:$USER $HOME/ooni
chown -R $USER:$USER $HOME/.ssh
chown -R $USER:$USER $HOME/.miniooni
