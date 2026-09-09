// This is a source file for WDK build of StormLib
// It is copied to the root folder during the build process

#pragma warning(disable: 4242)                      // '=' : conversion from 'Int32' to 'UChar', possible loss of data
#pragma warning(disable: 4244)                      // '=' : conversion from '__int64' to 'Int32', possible loss of data

#include "src\bzip2\blocksort.c"
#include "src\bzip2\bzlib.c"
#include "src\bzip2\compress.c"
#include "src\bzip2\crctable.c"
#include "src\bzip2\decompress.c"
#include "src\bzip2\huffman.c"
#include "src\bzip2\randtable.c"
