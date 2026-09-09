// This is a source file for WDK build of StormLib
// It is copied to the root folder during the build process

#pragma warning(disable:4242)            // deflate.c(1693) : warning C4242: '=' : conversion from 'unsigned int' to 'Bytef', possible loss of data

#define NO_DUMMY_DECL
#define NO_GZIP
#include "src\zlib\adler32.c"
#undef DO1
#undef DO8
#undef MIN
#include "src\zlib\compress.c"
#include "src\zlib\crc32.c"
#include "src\zlib\deflate.c"
#include "src\zlib\trees.c"
#include "src\zlib\zutil.c"

#undef COPY                             // Conflicting definition
#include "src\zlib\inflate.c"
#include "src\zlib\inffast.c"
#include "src\zlib\inftrees.c"
