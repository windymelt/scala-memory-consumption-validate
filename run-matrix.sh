#!/bin/sh

uname -a
free -h

if [ -f result.txt ]; then
  rm result.txt
fi

# GCはそのJVMのデフォルトに任せる

# OpenJDK (oracle)
# Temurin
# Coretto
# GraalVM

# 8 11 17

# OpenJDK x 11 openjdk-11
# OpenJDK x 17 openjdk-17

# Temurin x 8 temurin-8.0.362+9
# Temurin x 11 temurin-11.0.18+10
# Temurin x 17 temurin-17.0.6+10

# Coretto x 8 corretto-8.372.07.1
# Coretto x 11 corretto-11.0.19.7.1
# Coretto x 17 corretto-17.0.7.7.1

# 最新版のGraalVMはJava8をサポートしないので割愛
# GraalVM x 11 graalvm-22.3.1+java11
# GraalVM x 17 graalvm-22.3.1+java17

run () {
  asdf local java $1 2>&1 > /dev/null
  ./run.sh "$1" "$2" "$3" | tee -a result.txt
}

# OpenJDK17でJARを作る
asdf local java openjdk-17
sbt assembly

echo "JVM	BRAND	VER	COUNT	TIMESEC	MEMKIB"

run openjdk-11 openjdk 11
run openjdk-17 openjdk 17

run temurin-8.0.362+9 temurin 8
run temurin-11.0.18+10 temurin 11
run temurin-17.0.6+10 temurin 17

run corretto-8.372.07.1 corretto 8
run corretto-11.0.19.7.1 corretto 11
run corretto-17.0.7.7.1 corretto 17

run graalvm-22.3.1+java11 graalvm 11
run graalvm-22.3.1+java17 graalvm 17
