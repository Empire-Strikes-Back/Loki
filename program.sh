#!/bin/bash

repl(){
  clj \
    -X:repl deps-repl.core/process \
    :main-ns go-tour.main \
    :port 7788 \
    :host '"0.0.0.0"' \
    :repl? true \
    :nrepl? false
}

main(){
  clojure \
    -J-Dclojure.core.async.pool-size=1 \
    -J-Dclojure.compiler.direct-linking=false \
    -M -m go-tour.main
}

uberjar(){
  clj \
    -X:uberjar genie.core/process \
    :uberjar-name out/go-tour.standalone.jar \
    :main-ns go-tour.main
  mkdir -p out/jpackage-input
  mv out/go-tour.standalone.jar out/jpackage-input/
}

j-package(){
  OS=${1:?"Need OS type (windows/linux/mac)"}

  echo "Starting compilation..."

  if [ "$OS" == "windows" ]; then
    J_ARG="--win-menu --win-dir-chooser --win-shortcut"
          
  elif [ "$OS" == "linux" ]; then
      J_ARG="--linux-shortcut"
  else
      J_ARG=""
  fi

  jpackage \
    --input out/jpackage-input \
    --dest out \
    --main-jar go-tour.standalone.jar \
    --name "go-tour" \
    --main-class clojure.main \
    --arguments -m \
    --arguments go-tour.main \
    --app-version "1" \
    $J_ARG
}


"$@"