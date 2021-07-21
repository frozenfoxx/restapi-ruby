#!/usr/bin/env ash

HOST=${HOST:-"0.0.0.0"}
PORT=${PORT:-"80"}

rackup -o ${HOST} -p ${PORT} $@