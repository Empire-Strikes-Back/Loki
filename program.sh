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

"$@"