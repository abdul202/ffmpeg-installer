#!/bin/bash
#  Copyright (C) 2015 http://www.abdulibrahim.com/ All rights reserved.
#  This shell script will install the FFmpeg with the follwing libraries
# Yasm libmp3lame libogg libvorbis libvpx libtheora
# it has been created at 8/4/2015
# last edited 12-9-2017
# from this tutorial https://trac.ffmpeg.org/wiki/CompilationGuide/Centos?version=35
#

RED='\033[01;31m'
RESET='\033[0m'
export who=`whoami`
echo -n  "Press ENTER to start the installation  ...."
read option
if [[ $who == "root" ]];then
	echo -e $RED"we will start now with yum command"$RESET
yum install autoconf automake gcc gcc-c++ git libtool make nasm pkgconfig zlib-devel    
	echo -e $RED"In your home directory make a new directory to put all of the source code into"$RESET


mkdir ~/ffmpeg_sources

# install Yasm
echo -e $RED"install Yasm"$RESET
	cd ~/ffmpeg_sources
	curl -O http://www.abdulibrahim.com/production/files/ffmpeg/yasm-1.3.0.tar.gz
	tar xzvf yasm-1.3.0.tar.gz
	cd yasm
	autoreconf -fiv
	./configure --prefix="$HOME/ffmpeg_build" --bindir="$HOME/bin"
	make
	make install
	make distclean
echo "Yasm installed successfully"

# install libmp3lame
echo -e $RED"install lame"$RESET
	cd ~/ffmpeg_sources
	curl -O http://www.abdulibrahim.com/production/files/ffmpeg/lame-3.99.5.tar.gz
	tar xzvf lame-3.99.5.tar.gz
	cd lame-3.99.5
	./configure --prefix="$HOME/ffmpeg_build" --bindir="$HOME/bin" --disable-shared --enable-nasm
	make
	make install
	make distclean	
echo "lame installed successfully"

# install libogg
echo -e $RED"install libogg"$RESET
	cd ~/ffmpeg_sources
	curl -O http://www.abdulibrahim.com/production/files/ffmpeg/libogg-1.3.2.tar.gz
	tar xzvf libogg-1.3.2.tar.gz
	cd libogg-1.3.2
	./configure --prefix="$HOME/ffmpeg_build" --disable-shared
	make
	make install
	make distclean

echo "libogg installed successfully"

# install libvorbis
echo -e $RED"install libvorbis"$RESET
	cd ~/ffmpeg_sources
	curl -O http://www.abdulibrahim.com/production/files/ffmpeg/libvorbis-1.3.4.tar.gz
	tar xzvf libvorbis-1.3.4.tar.gz
	cd libvorbis-1.3.4
	./configure --prefix="$HOME/ffmpeg_build" --with-ogg="$HOME/ffmpeg_build" --disable-shared
	make
	make install
	make distclean

echo "libvorbis installed successfully"

# install libvpx
echo -e $RED"install libvpx"$RESET
	cd ~/ffmpeg_sources
	curl -O http://www.abdulibrahim.com/production/files/ffmpeg/libvpx.1.6.1.tar.gz
	tar xzvf libvpx.1.6.1.tar.gz
	cd libvpx
	./configure --prefix="$HOME/ffmpeg_build" --disable-examples
	make
	make install
	make clean

echo "libvpx installed successfully"

# install libtheora
echo -e $RED"install libtheora"$RESET
	cd ~/ffmpeg_sources
	curl -O http://www.abdulibrahim.com/production/files/ffmpeg/libtheora-1.1.1.tar.gz
	tar xzvf libtheora-1.1.1.tar.gz
	cd libtheora-1.1.1
	./configure --prefix="$HOME/ffmpeg_build" --with-ogg="$HOME/ffmpeg_build" --disable-examples --disable-shared --disable-sdltest --disable-vorbistest
	make
	make install
	make distclean

echo "libtheora installed successfully"

# install ffmpeg
echo -e $RED"install ffmpeg"$RESET

	cd ~/ffmpeg_sources
	git clone --depth 1 https://github.com/FFmpeg/FFmpeg
	cd FFmpeg
	PKG_CONFIG_PATH="$HOME/ffmpeg_build/lib/pkgconfig" ./configure --prefix="$HOME/ffmpeg_build" --extra-cflags="-I$HOME/ffmpeg_build/include" --extra-ldflags="-L$HOME/ffmpeg_build/lib" --bindir="/usr/local/bin" --enable-gpl --enable-nonfree --enable-libmp3lame --enable-libvorbis --enable-libvpx --enable-libtheora
	make
	make install
	make distclean
	hash -r

echo "ffmpeg installed successfully"



# this for the first if 
else
        echo "                  Sorry  Buddy, you are not a root user. This is not for yours."
        echo "                  You need admin privilege for installing this applications"
fi
