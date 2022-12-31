#!/bin/sh
HOME=/home/probe
USER=probe
adduser $USER
mkdir -p $HOME/ooni/oonirun
mkdir -p $HOME/ooni/privaterun
mkdir -p $HOME/ooni/store
mkdir -p $HOME/.miniooni
chown -R $USER:$USER $HOME/ooni
