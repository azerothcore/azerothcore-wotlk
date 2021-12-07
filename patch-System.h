--- /home/kaiser/azerothcore/deps/g3dlite/include/G3D/System.h.orig	2021-12-06 04:25:58.236612000 -0500
+++ /home/kaiser/azerothcore/deps/g3dlite/include/G3D/System.h	2021-12-04 17:39:44.312342000 -0500
@@ -20,7 +20,7 @@
 #include "G3D/BinaryFormat.h"
 #include "G3D/FileNotFound.h"
 #include <string>
-
+#include <sys/time.h>
 #if defined(__aarch64__)
 #include <sys/time.h>
 #endif
