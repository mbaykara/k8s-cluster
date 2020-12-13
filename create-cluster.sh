#!/bin/bash

cd control && vagrant up
if [ $? = 0 ]; then
  cd ../worker1 && vagrant up
  if [ $? = 0 ]; then
    cd ../worker2 && vagrant up &
  fi
fi

