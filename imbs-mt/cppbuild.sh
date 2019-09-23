#!/bin/bash
# This file is meant to be included by the parent cppbuild.sh script
if [[ -z "$PLATFORM" ]]; then
    pushd ..
    bash cppbuild.sh "$@" imbs-mt
    popd
    exit
fi

IMBS_VERSION=master
download https://github.com/dbloisi/imbs-mt/archive/master.zip imbs-mt-$IMBS_VERSION.zip

mkdir -p $PLATFORM
cd $PLATFORM
INSTALL_PATH=`pwd`
mkdir -p include lib bin
unzip -o ../imbs-mt-$IMBS_VERSION.zip
cd imbs-mt-$IMBS_VERSION
patch CMakeLists.txt < ../../../imbs-mt.patch || true

OPENCV_PATH=$INSTALL_PATH/../../../opencv/cppbuild/$PLATFORM/

if [[ -n "${BUILD_PATH:-}" ]]; then
    PREVIFS="$IFS"
    IFS="$BUILD_PATH_SEPARATOR"
    for P in $BUILD_PATH; do
        if [[ -d "$P/include/opencv2" ]]; then
            OPENCV_PATH="$P"
        fi
    done
    IFS="$PREVIFS"
fi

case $PLATFORM in
    linux-x86_64)
        $CMAKE -j $MAKEJ -DBUILD_SHARED_LIBS=ON -DCMAKE_BUILD_TYPE=Release -DOpenCV_DIR=$OPENCV_PATH/lib/cmake/opencv4/ .
        make -j $MAKEJ
        cp *.h ../include
        cp *.hpp ../include
        cp *.so ../lib
        ;;
    windows-x86_64)
        "$CMAKE" -j $MAKEJ -G "NMake Makefiles" -DCMAKE_BUILD_TYPE=Release -DOpenCV_DIR=$OPENCV_PATH .
        nmake
        cp *.h ../include
        cp *.hpp ../include
        cp *.dll ../lib
        ;;
    *)
        echo "Error: Platform \"$PLATFORM\" is not supported"
        ;;
esac

cd ../..
