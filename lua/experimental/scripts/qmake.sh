#!/bin/bash

RED='\033[0;31m'
GREEN='\033[0;32m'
ORANGE='\033[0;33m'
BLUE='\033[0;34m'
PURPLE='\033[1;35m'
NC='\033[0m'

# Проверяем что были переданы аргументы
if [ $# -eq 0 ]; then
    echo "${RED}No parameters found! ${NC}"
    exit 1
fi
# pwd
pro=$(ls | grep *.pro)
echo "Parameters $1 $2"
# pro=$1
target=$1
# window system
ws=$2
echo "pro=${pro} target=${target} ws=${ws}"
echo "-------------"
echo "Pro-file: ${ORANGE}$pro ${NC}"
echo "Target: ${ORANGE}$target ${NC}"
echo "Window system: ${ORANGE}$ws ${NC}"
# TODO: проверка корректности параметров

# TODO: различные сценарии сборки в зависимости от введенных параметров

cd build || exit 

# KPDA
CXXx86=/opt/kpda2020/host/linux64/x86_64/usr/bin/ntox86-g++-4.8.3
CCx86=/opt/kpda2020/host/linux64/x86_64/usr/bin/ntox86-gcc-4.8.3

CXXppc=/opt/kpda2020/host/linux64/x86_64/usr/bin/ntoppc-g++-4.8.3
CCppc=/opt/kpda2020/host/linux64/x86_64/usr/bin/ntoppc-gcc-4.8.3

# local 
CXX_clang=/usr/bin/clang++-14
CC_clang=/usr/bin/clang-14

CXX_gcc=/usr/bin/g++
CC_gcc=/usr/bin/gcc


echo "COMPILER_PATH=$CXXx86"

# ppc qws qt4.8.6
# -r -spec qws/qnx-ppc-g++

# ppc qpa qt4.8.7
# -r -spec qpa/qnx-ppc-g++

# x86 qpa qt4.8.7
# -r -spec qpa/qnx-i386-g++

# x86 qws qt4.8.6
# -r -spec unsupported/qws/qnx-i386-g++
#qnx-x86-g++
# Qt 4.8.6
# Command: c:/QtSDK/QtSDK_487_x86/bin/qmake.exe -spec c:/QtSDK/QtSDK_487_x86/mkspecs/qpa/qnx-i386-g++ -o Makefile EmulatorGUI.pro
QMAKE_486_QWS=C:\QtSDK\QtSDK_486\bin\qmake.exe
QMAKE_487_QPA=C:\QtSDK\QtSDK_487\bin\qmake.exe

QMAKE_487_X86=c:/QtSDK/QtSDK_487_x86/bin/qmake.exe 

QMAKE_QT5=/lib/x86_64-linux-gnu/qt5/bin/qmake

#QMAKE
# Qt 4.8.6
if [ "$target" = "x86" ]; then
    if [ "$ws" = "qws" ]; then
        # $QMAKE_487_X86 ../$pro -r -spec qws/qnx-i386-g++ QMAKE_CXX=$CXXx86 QMAKE_CC=$CCx86 QMAKE_LINK=$CXXx86

        $QMAKE_487_X86 ../$pro -r -spec qws/qnx-i386-g++ QMAKE_CXX=$CXXx86 QMAKE_CC=$CCx86 QMAKE_LINK=$CXXx86
        exit 0
    fi
    if [ "$ws" = "qpa" ]; then
        $QMAKE_487_X86 ../$pro -r -spec c:/QtSDK/QtSDK_487_x86/mkspecs/qpa/qnx-i386-g++ -o Makefile
        exit 0
    fi
    
fi

if [ "$target" = "ppc" ]; then
    if [ "$ws" = "qws" ]; then
        $QMAKE_486_QWS ../$pro -r -spec qws/qnx-ppc-g++ QMAKE_CXX=$CXXppc QMAKE_CC=$CCppc QMAKE_LINK=$CXXppc
        exit 0
    fi
    if [ "$ws" = "qpa" ]; then
        $QMAKE_487_QPA ../$pro -r -spec qpa/qnx-ppc-g++ QMAKE_CXX=$CXXppc QMAKE_CC=$CCppc QMAKE_LINK=$CXXppc
        exit 0
    fi
fi

# for local qt5
if [ "$target" = "local" ]; then
    if [ "$ws" = "clang" ]; then
        bear -- $QMAKE_QT5 ../$pro -r QMAKE_CXX=$CXX_clang QMAKE_CC=$CC_clang QMAKE_LINK=$CXX_clang
        exit 0
    fi
    if [ "$ws" = "gcc" ]; then
        $QMAKE_QT5 ../$pro -r QMAKE_CXX=$CXX_gcc QMAKE_CC=$CC_gcc QMAKE_LINK=$CXX_gcc
        exit 0
    fi
fi

echo "${RED} Unsupported parameters ${NC}"
exit 1
