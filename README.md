# FFmpeg for android for dummies
This repository intent to be an ultimate guide for anyone who needs to build ffmpeg for android. 
## Motivation
 
Building applications is not a simple task and become even more complicated for those who does it very seldom, are not used to linux systems and need to cross-compile.
The motivation was my personal experience, when I needed a simple FFmpeg version for running a project on android took me longer to sucessfully build ffmpeg than all other project related stuff.

## Setting-up
 
This script was sucessffully tested on a fresh Ubuntu 16.04 VM, all the dependencies and envoirement settings will be done by the script, the user only needs:
1. Download [Android NDK](https://developer.android.com/ndk/downloads/)
2. Adjust ```export NDK=/path/to/ndk``` to point to the right ndk folder

## FFmpeg settings
This script download and build the following ffmpeg libraries:
* x264 (GPL 2.0)
* opus (BSD)
* fdk-aac (non-free)
* lame mp3 (LGPL)
* ogg (BSD)
* vorbis (BSD)
* freetype (GPL 3.0)
* fontconfig (GPL)
* libpng  (GPL)
* zlib (GPL)
* openssl (Apache License)
* librtmp (GPL 2.0)

You may add or remove dependencies according to your needs

## Running
You shall run the script with the command: 
```./builder.sh ARCH API_LVL TEMP_DIR```

Supported ```ARCH```:  "arm", "armv7-a", "arm-v7n", "arm64-v8a", "i686", "x86_64" ```TARGET_PLATFORM``` must be the numeric android api level you are targeting 

The *ffmpeg* binary should in folder ```final/$ARCH/ffmpeg``` after build succeed.

## FFmpeg license
This repository uses code of **FFmpeg 4.0** licensed under the LGPLv2.1 and its source can be downloaded [here](https://ffmpeg.org/releases/ffmpeg-4.0.tar.bz2).

## Credits
This script was based on [Khang-NT](https://github.com/Khang-NT/ffmpeg-binary-android) repository
