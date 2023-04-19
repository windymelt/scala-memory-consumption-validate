#!/bin/sh

run () {
  echo === $1 ===
  \time -f "Command  : %C\nReal time: %e sec\nMax RSS  : %M KiB\n" $2 -u $3 2>&1
}

start () {
  run "$1" "$2" 1000
  run "$1" "$2" 1000000
  run "$1" "$2" 10000000
  run "$1" "$2" 100000000
}

java -version
echo "JAVA_OPTS"
echo $JAVA_OPTS
sbt assembly
du -h target/scala-3.2.2/root-assembly-0.1.0-SNAPSHOT.jar
start Scala "java -jar target/scala-3.2.2/root-assembly-0.1.0-SNAPSHOT.jar"
