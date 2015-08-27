#!/bin/sh

rm -fr build
mkdir -p build
cp -a ../../jee/ build
cp etc/persistence.xml build/src/main/resources/META-INF
cd build
mvn clean install
