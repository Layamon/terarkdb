#!/bin/bash

BASE=$PWD
OUTPUT=output
mkdir -p $OUTPUT

if test -n "$BUILD_BRANCH"; then
    # this script is run in SCM auto build
    git checkout "$BUILD_BRANCH"
    sudo apt-get update
    sudo apt-get install -y libaio-dev
else
    echo you must ensure libaio-dev have been installed
fi


git submodule update --init --recursive

cd $BASE/$OUTPUT && cmake ../ -DCMAKE_BUILD_TYPE=RelWithDebInfo -DWITH_TOOLS=ON -DWITH_TERARK_ZIP=ON
cd $BASE/$OUTPUT && make -j $(nproc) && make install
