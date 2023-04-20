#!/bin/sh

JVM=$1
JVMCATEGORY=$2
JVAR=$3

run () {
  JAVA_OPTS="-Xms100M -Xmx2G" \time -f "$JVM\t$JVMCATEGORY\t$JVAR\t$3\t%e\t%M\t" $2 -u $3 2>&1
}

start () {
  run "$1" "$2" 1000
  run "$1" "$2" 1000000
  run "$1" "$2" 10000000
  run "$1" "$2" 100000000
}

start Scala "java -jar target/scala-3.2.2/root-assembly-0.1.0-SNAPSHOT.jar"
