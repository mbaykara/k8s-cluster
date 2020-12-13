#!/bin/bash

cd control && vagrant destroy -f 
cd ../worker1 && vagrant destroy -f 
cd ../worker2 && vagrant destroy -f 
if [ $? = 0 ]; then
  exit 0
fi
