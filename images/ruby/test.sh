#!/bin/bash -x

cd test
docker build -t do276/test-ruby .
docker run -d --name test-ruby -p 30080:8080 do276/test-ruby
sleep 3
# Expected result is "Hello there" no HTML formatting
curl http://127.0.0.1:30080/hi
