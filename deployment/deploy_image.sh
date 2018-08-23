#!/bin/bash
git clone https://github.com/vedsted/ca-project
docker build -t vedsted/codechan:latest .
docker push vedsted/codechan:latest
rm -rf codechan
