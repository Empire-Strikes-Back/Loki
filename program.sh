#!/bin/bash


run(){
  cd src/Loki && go run $1
}

"$@"