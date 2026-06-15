#ifndef __REVISION_H__
#define __REVISION_H__
 #define _REVISION                  "@rev_id_str@"
 #define _HASH                      "@rev_hash@"
 #define _DATE                      "@rev_date@"
 #define _BRANCH                    "@rev_branch@"
 #define _CMAKE_COMMAND             R"(@CMAKE_COMMAND@)"
 #define _CMAKE_VERSION             R"(@CMAKE_VERSION@)"
 #define _CMAKE_HOST_SYSTEM         R"(@CMAKE_HOST_SYSTEM_NAME@ @CMAKE_HOST_SYSTEM_VERSION@)"
 #define _SOURCE_DIRECTORY          R"(@CMAKE_SOURCE_DIR@)"
 #define _BUILD_DIRECTORY           R"(@BUILDDIR@)"
 #define _MYSQL_EXECUTABLE          R"(@MYSQL_EXECUTABLE@)"
 #define AC_COMPANYNAME_STR         "AzerothCore"
 #define AC_LEGALCOPYRIGHT_STR      "(c)2016-@rev_year@ AzerothCore"
 #define AC_FILEVERSION             0,0,0
 #define AC_FILEVERSION_STR         "@rev_hash@ @rev_date@ (@rev_branch@ branch)"
 #define AC_PRODUCTVERSION          AC_FILEVERSION
 #define AC_PRODUCTVERSION_STR      AC_FILEVERSION_STR
#endif // __REVISION_H__
