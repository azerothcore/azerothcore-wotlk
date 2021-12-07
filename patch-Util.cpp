diff --git a/src/common/Utilities/Util.cpp b/src/common/Utilities/Util.cpp
index 45ed122..54c2015 100644
--- a/src/common/Utilities/Util.cpp
+++ b/src/common/Utilities/Util.cpp
@@ -87,6 +87,12 @@ time_t LocalTimeToUTCTime(time_t time)
 {
 #if (defined(WIN32) || defined(_WIN32) || defined(__WIN32__))
     return time + _timezone;
+#elif defined(__FreeBSD__)
+    struct tm tm;
+
+    gmtime_r(&time, &tm);
+    tm.tm_isdst = -1;
+    return mktime(&tm);
 #else
     return time + timezone;
 #endif
