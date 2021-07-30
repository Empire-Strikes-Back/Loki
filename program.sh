#!/bin/bash


install_golang(){
  curl -LO https://get.golang.org/$(uname)/go_installer && chmod +x go_installer && ./go_installer && rm go_installer
  GOPATH=/root/go
  PATH=$PATH:/usr/local/go/bin:${GOPATH}/bin
  GO_DIST=go1.15.7.linux-amd64.tar.gz
  GO111MODULE=on
  curl -LO https://golang.org/dl/${GO_DIST} \
    && tar -C /usr/local -xzf ${GO_DIST} \
    && rm ${GO_DIST} \
    && go version
}

push(){
  ORIGIN=$(git remote get-url origin)
  rm -rf .git
  git init -b main
  git remote add origin $ORIGIN
  git config --local include.path ../.gitconfig
  git add .
  git commit -m "i am go-tour program"
  git push -f -u origin main
}


"$@"