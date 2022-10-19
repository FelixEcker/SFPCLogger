#!/usr/bin/bash

rm -rf out
mkdir out

fpc src/test.pas -FE"out/" -O4
out/test.exe
