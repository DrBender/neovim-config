#!/bin/bash
RED='\033[0;31m'
GREEN='\033[0;32m'
ORANGE='\033[0;33m'
BLUE='\033[0;34m'
PURPLE='\033[1;35m'
NC='\033[0m'
# Проверяем что были переданы аргументы
echo "Parameters $1"
cd build || exit
# path=$1
commad=$1

if [ $# -eq 0 ]; then
    echo "${RED}No parameters found! ${NC}"
    exit 1
fi

if [ "$commad" = "clean" ]; then
    echo "${GREEN}Cleaning....${NC}"
    /opt/kpda2020/host/linux64/x86_64/usr/bin/make clean
    echo "${GREEN}Cleaning FINISHED!${NC}"
    exit 0
fi

if [ "$commad" = "make" ]; then
    echo "${PURPLE}Starting making project${NC}"
    # /opt/kpda2020/host/linux64/x86_64/usr/bin/make -j 2
    bear -- /opt/kpda2020/host/linux64/x86_64/usr/bin/make -j 2
    mv compile_commands.json ../compile_commands.json
    echo "${PURPLE}Making FINISHED!${NC}"
    exit 0
fi

echo "${RED}Unsupported command ${NC}"
exit 1
