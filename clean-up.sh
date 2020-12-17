#!/bin/bash

vagrant destroy -f 

if [ $? = 0 ]; then
  exit 0
fi
