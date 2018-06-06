#!/bin/bash

## $1: target
## $2: platform
## $3: prefix
# Support targets: "arm", "armv7-a", "arm-v7n", "arm64-v8a", "i686", "x86_64"

set -e
set -x

export NDK=/home/rafa/Desktop/m4/ndk

## Support either NDK linux or darwin (mac os)
## Check $NDK exists
if [ "$NDK" = "" ] || [ ! -d $NDK ]; then
	echo "NDK variable not set or path to NDK is invalid, exiting..."
	exit 1
fi


export TARGET=$1
export PLATFORM=$2
export PREFIX=$(pwd)/$3
FINAL_DIR=$(pwd)/final/$TARGET


sudo apt-get update
sudo apt-get -y install automake autopoint libtool gperf libssl-dev 

 
 

LIB=none
VERSION=0


LIBFREETYPE_VERSION="2.9"
LIBEXPAT_VERSION="2.2.5"
LIBFONTCONFIG_VERSION="2.13.0"
LIBUUID_VERSION="1.0.3"
FFMPEG_VERSION="4.0"
LIBX264_VERSION="snapshot-20180601-2245-stable"
FDK_AAC_VERSION="0.1.6"
LAME_VERSION="3.100"
OPUS_VERSION="1.1.5"
LIBOGG_VERSION="1.3.2"
LIBVORBIS_VERSION="1.3.4"
ZLIB_VERSION="1.2.11"
LIBPNG12_VERSION="1.2.59"
LIBOPENSSL_VERSION="1.0.2o"
LIBTRMP_VERSION="2.3"

LIB="ffmpeg"
VERSION=${FFMPEG_VERSION}

if [ ! -d ${LIB} ]; then
    echo "Downloading ${LIB}-${VERSION}"
    curl -LO https://www.ffmpeg.org/releases/${LIB}-${FFMPEG_VERSION}.tar.gz
    echo "extracting ${LIB}-${VERSION}.tar.gz"
    tar -zxf ${LIB}-${VERSION}.tar.gz
	mv ${LIB}-${VERSION} ${LIB}
else
    echo "Using existing `pwd`/${LIB}"
fi

LIB="x264"
VERSION=${LIBX264_VERSION}
if [ ! -d ${LIB} ]; then
    echo "Downloading ${LIB}-${VERSION}"
    curl -O "ftp://ftp.videolan.org/pub/videolan/x264/snapshots/x264-$LIBX264_VERSION.tar.bz2"
    tar -xf ${LIB}-${VERSION}.tar.bz2
	mv ${LIB}-${VERSION} ${LIB}
else
    echo "Using existing `pwd`/{$LIB}"
fi

LIB="opus"
VERSION=${OPUS_VERSION}
if [ ! -d ${LIB} ]; then
    echo "Downloading ${LIB}-${VERSION}"
    curl -LO https://archive.mozilla.org/pub/opus/opus-${OPUS_VERSION}.tar.gz
    tar -xzf ${LIB}-${VERSION}.tar.gz
	mv ${LIB}-${VERSION} ${LIB}
else
    echo "Using existing `pwd`/opus-${OPUS_VERSION}"
fi

LIB="fdk-aac"
VERSION=${FDK_AAC_VERSION}
if [ ! -d ${LIB} ]; then
    echo "Downloading ${LIB}-${VERSION}"
    curl -LO http://downloads.sourceforge.net/opencore-amr/fdk-aac-${FDK_AAC_VERSION}.tar.gz
    tar -xzf ${LIB}-${VERSION}.tar.gz
	mv ${LIB}-${VERSION} ${LIB}
else
    echo "Using existing `pwd`/${LIB}"
fi

LIB="lame"
LAME_MAJOR="3.100"
VERSION=${LAME_VERSION}
if [ ! -d ${LIB} ]; then
    echo "Downloading ${LIB}-${VERSION}"
    curl -LO http://downloads.sourceforge.net/project/lame/lame/${LAME_MAJOR}/lame-${LAME_VERSION}.tar.gz
    tar -xzf ${LIB}-${VERSION}.tar.gz
    curl -L -o ${LIB}-${VERSION}/config.guess "http://git.savannah.gnu.org/gitweb/?p=config.git;a=blob_plain;f=config.guess;hb=HEAD"
    curl -L -o ${LIB}-${VERSION}/config.sub "http://git.savannah.gnu.org/gitweb/?p=config.git;a=blob_plain;f=config.sub;hb=HEAD"
	mv ${LIB}-${VERSION} ${LIB}
else
    echo "Using existing `pwd`/${LIB}"
fi

LIB="libogg"
VERSION=${LIBOGG_VERSION}
if [ ! -d ${LIB} ]; then
    echo "Downloading ${LIB}-${VERSION}"
    curl -LO http://downloads.xiph.org/releases/ogg/libogg-${LIBOGG_VERSION}.tar.gz
    tar -xzf ${LIB}-${VERSION}.tar.gz
	mv ${LIB}-${VERSION} ${LIB}
else
    echo "Using existing `pwd`/${LIB}"
fi

LIB="libvorbis"
VERSION=${LIBVORBIS_VERSION}
if [ ! -d ${LIB} ]; then
    echo "Downloading ${LIB}-${VERSION}"
    curl -LO http://downloads.xiph.org/releases/vorbis/libvorbis-${LIBVORBIS_VERSION}.tar.gz
    tar -xzf ${LIB}-${VERSION}.tar.gz
	mv ${LIB}-${VERSION} ${LIB}
else
    echo "Using existing `pwd`/${LIB}"
fi

LIB="freetype"
VERSION=${LIBFREETYPE_VERSION}
if [ ! -d ${LIB} ]; then
    echo "Downloading ${LIB}-${VERSION}"
    curl -LO https://download.savannah.gnu.org/releases/freetype/freetype-${LIBFREETYPE_VERSION}.tar.gz
    tar -xzf ${LIB}-${VERSION}.tar.gz
	mv ${LIB}-${VERSION} ${LIB}
else
    echo "Using existing `pwd`/${LIB}"
fi


LIB="expat"
VERSION=${LIBEXPAT_VERSION}
if [ ! -d ${LIB} ]; then
    echo "Downloading ${LIB}-${VERSION}"
    curl -LO http://downloads.sourceforge.net/project/expat/expat/${LIBEXPAT_VERSION}/expat-${LIBEXPAT_VERSION}.tar.bz2
    tar -xjf ${LIB}-${VERSION}.tar.bz2
	mv ${LIB}-${VERSION} ${LIB}
else
    echo "Using existing `pwd`/${LIB}"
fi

LIB="fontconfig"
VERSION=${LIBFONTCONFIG_VERSION}
if [ ! -d ${LIB} ]; then
    echo "Downloading ${LIB}-${VERSION}"
    curl -LO https://www.freedesktop.org/software/fontconfig/release/fontconfig-${LIBFONTCONFIG_VERSION}.tar.gz
    tar -xzf ${LIB}-${LIBFONTCONFIG_VERSION}.tar.gz
	mv ${LIB}-${VERSION} ${LIB}
else
    echo "Using existing `pwd`/${LIB}"
fi

LIB="libuuid"
VERSION=${LIBUUID_VERSION}
if [ ! -d ${LIB} ]; then
    echo "Downloading ${LIB}-${VERSION}"
    curl -LO https://ufpr.dl.sourceforge.net/project/libuuid/libuuid-${LIBUUID_VERSION}.tar.gz
    tar -xzf ${LIB}-${VERSION}.tar.gz
	mv ${LIB}-${VERSION} ${LIB}
else
    echo "Using existing `pwd`/${LIB}"
fi
 
 
LIB="libpng"
VERSION=${LIBPNG12_VERSION}
if [ ! -d ${LIB} ]; then
    echo "Downloading ${LIB}-${VERSION}"
    curl -LO https://ufpr.dl.sourceforge.net/project/libpng/libpng12/${VERSION}/libpng-${VERSION}.tar.gz
    tar -xzf ${LIB}-${VERSION}.tar.gz
	mv ${LIB}-${VERSION} ${LIB}
else
    echo "Using existing `pwd`/${LIB}"
fi


LIB="zlib"
VERSION=${ZLIB_VERSION}
if [ ! -d ${LIB} ]; then
    echo "Downloading ${LIB}-${VERSION}"
    curl -LO https://zlib.net/zlib-${VERSION}.tar.gz
    tar -xzf ${LIB}-${VERSION}.tar.gz
	mv ${LIB}-${VERSION} ${LIB}
else
    echo "Using existing `pwd`/${LIB}"
fi 

LIB="openssl"
VERSION=${LIBOPENSSL_VERSION}
if [ ! -d ${LIB} ]; then
    echo "Downloading ${LIB}-${VERSION}"
    curl -LO https://www.openssl.org/source/openssl-${VERSION}.tar.gz
    tar -xzf ${LIB}-${VERSION}.tar.gz
	mv ${LIB}-${VERSION} ${LIB}
else
    echo "Using existing `pwd`/${LIB}"
fi 





LIB="rtmpdump"
VERSION=${LIBTRMP_VERSION}
if [ ! -d ${LIB} ]; then
    git clone git://git.ffmpeg.org/rtmpdump
 
fi


 

if [ ! -e "libunistring2_0.9.9-0ubuntu1_amd64.deb" ]; then
curl -LO http://mirrors.kernel.org/ubuntu/pool/main/libu/libunistring/libunistring2_0.9.9-0ubuntu1_amd64.deb
sudo apt install ./libunistring2_0.9.9-0ubuntu1_amd64.deb
fi

if [ ! -e "gettext_0.19.8.1-6_amd64.deb" ]; then
curl -LO http://mirrors.kernel.org/ubuntu/pool/main/g/gettext/gettext_0.19.8.1-6_amd64.deb
sudo apt install ./gettext_0.19.8.1-6_amd64.deb
fi

if [ ! -e "gettext-base_0.19.8.1-6_amd64.deb" ]; then
curl -LO http://mirrors.kernel.org/ubuntu/pool/main/g/gettext/gettext-base_0.19.8.1-6_amd64.deb
sudo apt install ./gettext-base_0.19.8.1-6_amd64.deb
fi

if [ ! -e "autopoint_0.19.8.1-6_all.deb" ]; then
curl -LO http://mirrors.kernel.org/ubuntu/pool/main/g/gettext/autopoint_0.19.8.1-6_all.deb
sudo apt install ./autopoint_0.19.8.1-6_all.deb
fi

if [ ! -e "libpng12-0_1.2.54-1ubuntu1_amd64.deb" ]; then
curl -LO http://mirrors.kernel.org/ubuntu/pool/main/libp/libpng/libpng12-0_1.2.54-1ubuntu1_amd64.deb
sudo apt install ./libpng12-0_1.2.54-1ubuntu1_amd64.deb
fi


function build_one
{

TOOLCHAIN=${NDK}/toolchain/${ARCH}
SYSROOT=${TOOLCHAIN}/sysroot
CROSS_PREFIX=${TOOLCHAIN}/bin/arm-linux-androideabi-

$NDK/build/tools/make-standalone-toolchain.sh --use-llvm  --platform=${PLATFORM} --install-dir=${TOOLCHAIN}  --arch=${ARCH} --stl=libc++ --deprecated-headers  || true


 
 
 

export PKG_CONFIG="$(which pkg-config)"
export PKG_CONFIG_PATH="${PREFIX}/lib/pkgconfig"
export CC="${CROSS_PREFIX}clang"
export CXX="${CROSS_PREFIX}clang++"
export CPP="${CROSS_PREFIX}cpp"
export AR="${CROSS_PREFIX}ar"
export LD="${CROSS_PREFIX}ld"
export NM="${CROSS_PREFIX}nm"
export RANLIB="${CROSS_PREFIX}ranlib"
export STRIP="${CROSS_PREFIX}strip"
export LDFLAGS="-L${PREFIX}/lib -L${TOOLCHAIN}/lib -L${SYSROOT}/usr/lib -fPIE  --sysroot=${SYSROOT} "
export CFLAGS="${OPTIMIZE_CFLAGS} -I${PREFIX}/include  -I${SYSROOT}/usr/include -fPIE " 
export CXXFLAGS="${CFLAGS} "
export CPPFLAGS="${CFLAGS} "
export PATH="$PATH:$PREFIX/bin:$NDK/build"
export CROSS_SYSROOT="${SYSROOT}"

  

mkdir -p ${PREFIX}
mkdir -p ${PREFIX}/lib
mkdir -p ${PREFIX}/include

 
cp -p  $SYSROOT/usr/lib/libz.a $PREFIX/lib/libz.a
cp -p  $SYSROOT/usr/include/zlib.h $PREFIX/include/zlib.h
 



  
    pushd x264
        ./configure \
            --cross-prefix=$CROSS_PREFIX \
            --sysroot=$SYSROOT \
            --host=$HOST \
            --enable-pic \
            --enable-static \
            --disable-shared \
            --disable-cli \
            --disable-opencl \
            --prefix=$PREFIX \
            $LIBX264_FLAGS
			
        make clean  
        make -j8  
        make install 
    popd


    # Non-free
    pushd fdk-aac
        ./configure \
            --prefix=$PREFIX \
            --host=$HOST \
            --enable-static \
            --disable-shared \
            --with-sysroot=$SYSROOT

        make clean
        make -j8
        make install
    popd

 
	
pushd lame
./configure \
    --prefix=$PREFIX \
    --host=$HOST \
    --enable-static \
    --disable-shared \
	--disable-frontend \
    --with-sysroot=$SYSROOT
make clean
make -j8 
make install
popd





pushd libogg
./configure \
    --prefix=$PREFIX \
    --host=$HOST \
    --enable-static \
    --disable-shared \
    --with-sysroot=$SYSROOT

make clean
make -j8 
make install
popd



pushd libvorbis
./configure \
    --prefix=$PREFIX \
    --host=$HOST \
    --enable-static \
    --disable-shared \
    --with-sysroot=$SYSROOT \
    --with-ogg=$PREFIX
make clean
make  -j8 
make install
popd



pushd opus
./configure \
    --prefix=$PREFIX \
    --host=$HOST \
    --enable-static \
    --disable-shared \
    --disable-doc \
    --disable-extra-programs
make clean
make -j8
make install V=1
popd



	pushd libpng
	./configure \
            --prefix=$PREFIX \
            --host=$HOST \
			--with-arch=$ARCH\
            --with-sysroot=$SYSROOT \
	 --disable-shared \
	 --enable-static \
	 --with-pic 
	
	make clean
	make -j8
	make install 
	
	popd
 
 

    # required by fontconfig
    pushd libuuid
        ./configure \
            --prefix=$PREFIX \
            --host=$HOST \
            --enable-static \
			--with-sysroot=$SYSROOT \
            --disable-shared 
        
        make clean
        make -j8  
        make install
    popd

    # required by fontconfig
    pushd expat
        ./configure \
            --prefix=$PREFIX \
            --host=$HOST \
            --with-pic \
            --enable-static \
			--with-sysroot=$SYSROOT \
			--without-docbook \
			--disable-docs \
			--without-xmlwf \
            --disable-shared 

        make clean 
        make -j8 
        make install
    popd



	 pushd freetype
        ./configure \
            --prefix=$PREFIX \
            --host=$HOST \
            --with-pic \
            --with-zlib=yes \
            --enable-static \
			--with-sysroot=$SYSROOT \
			--without-old-mac-fonts \
			--without-fsspec \
			--without-fsref \
			--without-quickdraw-toolbox \
			--without-quickdraw-carbon  \
			--without-ats \
			--without-png \
			--without-bzip2 \
			--disable-shared 
        
        make clean
        make -j8 
        make install
    popd
 
 
 
    pushd fontconfig 
         
        ./configure  PKG_CONFIG="$(which pkg-config)" PKG_CONFIG_PATH="${PREFIX}/lib/pkgconfig" \
            --prefix=$PREFIX \
            --host=$HOST \
			--with-arch=$ARCH\
            --with-sysroot=$SYSROOT \
			--with-pic \
            --disable-libxml2 \
            --disable-iconv \
            --enable-static \
            --disable-shared \
            --disable-docs \
			--disable-nls \
			--disable-rpath
 
        make clean
        make -j8  
        make install
    popd
	

pushd openssl

 

#-D__ANDROID_API__=N
 ./Configure ${OPENSSL_ARCH} \
              --prefix=${PREFIX} \
              --with-zlib-include=${NDK}/sysroot/usr/include \
              --with-zlib-lib=${SYSROOT}/usr/lib \
              zlib \
			  no-hw \
              no-asm \
              no-shared \
              no-unit-test \
			  -I${TOOLCHAIN} \
			  -fPIE

	sed -e "s;-mandroid;;g" Makefile > tmp
	rm Makefile
	mv tmp Makefile
	
    make clean
	make -j8
    make install_sw
#make install_ssldirs
	
popd





 
  
 

pushd rtmpdump

pushd librtmp 
  

set -e
make clean
make SYS=android  prefix=${PREFIX} CROSS_COMPILE=${CROSS_PREFIX} CC=${CROSS_PREFIX}clang  SHARED= 
make SYS=android  prefix=${PREFIX} CROSS_COMPILE=${CROSS_PREFIX} CC=${CROSS_PREFIX}clang  SHARED= install 
  
popd 

popd



#the file /home/rafa/Desktop/m4/ndk/toolchain/arm/sysroot/usr/include/asm-generic/termbits.h has a definition also defined on lavcoded/aac.c, so we need to comment it otherwise ffmpeg wont compile
BADFILE=/home/rafa/Desktop/m4/ndk/toolchain/arm/sysroot/usr/include/asm-generic/termbits.h
sed -e "s;#define B0 0000000;//#define B0 0000000;" ${BADFILE} > ${BADFILE}n
mv ${BADFILE} ${BADFILE}.bak
mv ${BADFILE}n ${BADFILE}

pushd ffmpeg
 
 CROSS_COMPILE_FLAGS="--target-os=linux \
        --arch=$ARCH \
        --cross-prefix=$CROSS_PREFIX \
        --enable-cross-compile \
        --sysroot=$SYSROOT"


   ./configure --prefix=$PREFIX \
        $CROSS_COMPILE_FLAGS \
        --pkg-config=$(which pkg-config) \
        --pkg-config-flags="--static" \
        --enable-pic \
        --enable-gpl \
        --enable-nonfree \
        \
        --disable-shared \
        --disable-static \
        \
        --enable-ffmpeg \
        --disable-ffplay \
        --disable-ffprobe \
		\
         --enable-libmp3lame \
  --enable-libopus \
  --enable-libvorbis \
  --enable-libx264 \
  --enable-libfdk-aac \
  --enable-bsf=aac_adtstoasc \
  --enable-librtmp \
  --enable-zlib  \
  --enable-libfreetype \
  --enable-openssl \
  --enable-libfontconfig \
         --enable-static\
  --disable-postproc\
  --disable-avdevice \
  --disable-avisynth        \
  --disable-bzlib          \
  --disable-coreimage\
  --disable-pixelutils\
  --disable-doc            \
  --disable-indevs\
  --disable-outdevs\
  --disable-protocols \
--enable-protocol=librtmp\
--enable-protocol=librtmpe\
--enable-protocol=librtmps\
--enable-protocol=crypto\
--enable-protocol=data\
--enable-protocol=file\
--enable-protocol=librtmpt\
--enable-protocol=librtmpte\
--enable-protocol=tcp\
--enable-protocol=rtp\
--enable-protocol=prompeg\
--enable-protocol=udp\
--enable-protocol=udplite\
--enable-protocol=srtp\
--disable-filters \
--enable-filter=abitscope\
--enable-filter=acompressor\
--enable-filter=acontrast\
--enable-filter=acopy\
--enable-filter=acrossfade\
--enable-filter=acrusher\
--enable-filter=atrim\
--enable-filter=adrawgraph\
--enable-filter=astreamselect\
--enable-filter=atadenoise\
--enable-filter=atempo\
--enable-filter=bbox\
--enable-filter=avectorscope\
--enable-filter=avgblur\
--enable-filter=deshake\
--enable-filter=displace\
--enable-filter=drawbox\
--enable-filter=drawgraph\
--enable-filter=drawgrid\
--enable-filter=phase\
--enable-filter=hwmap\
--enable-filter=hwupload\
--enable-filter=pp\
--enable-filter=pixdesctest\
--enable-filter=pixscope\
--enable-filter=interlace\
--enable-filter=interleave\
--enable-filter=join\
--enable-filter=qp\
--enable-filter=random\
--enable-filter=psnr\
--enable-filter=dynaudnorm\
--enable-filter=inflate\
--enable-filter=drawtext\
--enable-filter=silenceremove\
--enable-filter=smartblur\
--enable-filter=smptehdbars\
--enable-filter=pp7\
--enable-filter=pullup\
--enable-filter=split\
--enable-filter=spp\



	   
	
make clean
make  
make install

mkdir -p $DESTINATION_FOLDER/
cp $PREFIX/bin/ffmpeg $DESTINATION_FOLDER/

popd

rm ${BADFILE}
mv ${BADFILE}.bak ${BADFILE}

}


if [ $TARGET == 'arm-v7n' ]; then
    #arm v7n
    CPU=armv7-a
    ARCH=arm
    HOST=arm-linux-androideabi
    OPENSSL_ARCH="android shared no-ssl2 no-ssl3 no-hw "
    OPTIMIZE_CFLAGS="-mfloat-abi=softfp -mfpu=neon -marm -mtune=cortex-a8 -march=$CPU -Os -O3"
    ADDITIONAL_CONFIGURE_FLAG="--enable-neon "
    LIBX264_FLAGS=
 
	build_one
elif [ $TARGET == 'arm64-v8a' ]; then
    #arm64-v8a
    CPU=armv8-a
    ARCH=arm64
    OPENSSL_ARCH="linux-x86_64 shared no-ssl2 no-ssl3 no-hw"
	HOST=aarch64-linux-android
    OPTIMIZE_CFLAGS="-march=$CPU -Os -O3"
    ADDITIONAL_CONFIGURE_FLAG=
    LIBX264_FLAGS=
 
	build_one
elif [ $TARGET == 'x86_64' ]; then
    #x86_64
    CPU=x86-64
    ARCH=x86_64
OPENSSL_ARCH="linux-x86_64 shared no-ssl2 no-ssl3 no-hw"
	HOST=x86_64-linux-android
    OPTIMIZE_CFLAGS="-fomit-frame-pointer -march=$CPU -Os -O3"
    ADDITIONAL_CONFIGURE_FLAG=
    LIBX264_FLAGS=
 
	build_one
elif [ $TARGET == 'i686' ]; then
    #x86
    CPU=i686
    ARCH=i686
    OPTIMIZE_CFLAGS="-fomit-frame-pointer -march=$CPU -Os -O3"
    HOST=i686-linux-android
OPENSSL_ARCH="android shared no-ssl2 no-ssl3 no-hw "
	# disable asm to fix 
    ADDITIONAL_CONFIGURE_FLAG='--disable-asm' 
    LIBX264_FLAGS="--disable-asm"
 
	build_one
elif [ $TARGET == 'armv7-a' ]; then
    # armv7-a
    CPU=armv7-a
    ARCH=arm
OPENSSL_ARCH="android shared no-ssl2 no-ssl3 no-hw "
	HOST=arm-linux-androideabi
    OPTIMIZE_CFLAGS="-mfloat-abi=softfp -marm -march=$CPU -Os -O3 "
    ADDITIONAL_CONFIGURE_FLAG=
    LIBX264_FLAGS=
 
    build_one
elif [ $TARGET == 'arm' ]; then
    #arm
    CPU=armv5te
    ARCH=arm
OPENSSL_ARCH="android shared no-ssl2 no-ssl3 no-hw "
	HOST=arm-linux-androideabi
    OPTIMIZE_CFLAGS="-march=$CPU -Os -O3 "
    ADDITIONAL_CONFIGURE_FLAG=
    LIBX264_FLAGS="--disable-asm"
 
    build_one
 
else
    echo "Unknown target: $TARGET"
    exit 1
fi
