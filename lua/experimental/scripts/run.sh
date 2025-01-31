#!/bin/bash



pro=$(ls | grep *.pro)


test=$(grep -n "TARGET" "$pro" | awk -F"TARGET = " '{print $2}')

echo $(pwd)
cd build
echo "-----------------------------------------------"
./"$test"
echo "-----------------------------------------------"
echo "$test"
