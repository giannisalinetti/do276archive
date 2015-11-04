#!/bin/sh

# output should be a pretty formatted JSON object

curl -s http://localhost:18080/todo/api/items | jsonlint -f -

