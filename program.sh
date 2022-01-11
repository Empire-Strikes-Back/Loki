#!/bin/bash


run(){
  cd src/Loki && go run $1
}

hello(){
  cd hello && go run hello.go
}

"$@"