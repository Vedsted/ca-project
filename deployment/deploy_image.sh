#!/bin/bash
git clone https://github.com/vedsted/codechan
docker build -t vedsted/codechan:latest .
docker push vedsted/codechan:latest
rm -rf codechan