#!/bin/bash

if [ "$1" = "release" ]; then
        TARGET="release"
else
        TARGET="debug"
fi

PAKFILE=sp_pak_coop1.pk3
ORIGINALFOLDER=$(pwd)
CMAKEFOLDER=cmake

cd media/sp_pak_coop1

#zip -r $PAKFILE models/players/coop/* models/movespeeds/* maps/* scripts/* ui/* ./* levelshots/*
zip -r $PAKFILE ./ -x "*.svn*"

if [ "`uname`" = "Darwin" ]; then
        cp $PAKFILE ~/Library/Application\ Support/Wolfenstein/main/
fi
if [ "`uname`" = "Linux" ]; then
        cp $PAKFILE ~/.wolf/main
fi

cp $PAKFILE -t $ORIGINALFOLDER/$CMAKEFOLDER/main

mv $PAKFILE ../

echo "Creating bin.pk3"

if [ "`uname`" = "Darwin" ]; then
        cd "../../build/$TARGET-darwin-i386/main/"
        zip -r bin.pk3 *.dylib
        cp bin.pk3 ~/Library/Application\ Support/Wolfenstein/main/
        mv bin.pk3 ../../../media/
fi
if [ "`uname`" = "Linux" ]; then
        cd "../../build/$TARGET-linux-i386/main/"
        zip -r bin.pk3 *.so
        cp bin.pk3 ~/.wolf/main/
        mv bin.pk3 ../../../media/
fi

cd $ORIGINALFOLDER/$CMAKEFOLDER/main
zip -r bin.pk3 *.so
