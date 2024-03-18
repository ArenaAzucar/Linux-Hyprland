#!/bin/bash

#############

result=$(find "$PWD" -type f | exec grep "pacmanUpdate.sh")

sh $result