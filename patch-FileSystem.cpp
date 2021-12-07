--- /home/kaiser/AC/azerothcore/deps/g3dlite/source/FileSystem.cpp.orig	2021-12-06 04:24:08.078530000 -0500
+++ /home/kaiser/AC/azerothcore/deps/g3dlite/source/FileSystem.cpp	2021-12-04 17:41:21.994572000 -0500
@@ -26,9 +26,9 @@
     // Needed for _findfirst
 #   include <io.h>
 #  ifdef __MINGW32__
-#    define stat64 stat
+#    define stat stat
 #  else
-#    define stat64 _stat64
+#    define stat _stat
 #  endif
 #else
 #   include <dirent.h>
@@ -580,8 +580,8 @@
 int64 FileSystem::_size(const std::string& _filename) {
     const std::string& filename = FilePath::canonicalize(FilePath::expandEnvironmentVariables(_filename));
 
-    struct stat64 st;
-    int result = stat64(filename.c_str(), &st);
+    struct stat st;
+    int result = stat(filename.c_str(), &st);
     
     if (result == -1) {
 #if _HAVE_ZIP /* G3DFIX: Use ZIP-library only if defined */
