#ifndef TC9_VERSION_H
#define TC9_VERSION_H

/* Vendored snapshot of libsidecar-cpp generated version header.
 * Keep in sync with the libsidecar binary in this deps folder.
 * Upstream source of truth: project(libsidecar VERSION ...) in
 * game-server/libsidecar-cpp/CMakeLists.txt (generates this file).
 */

#define TC9_VERSION_MAJOR 1
#define TC9_VERSION_MINOR 0
#define TC9_VERSION_PATCH 0

#define TC9_VERSION_STRING "1.0.0"

/* major*10000 + minor*100 + patch */
#define TC9_VERSION_NUMBER \
    (TC9_VERSION_MAJOR * 10000 + TC9_VERSION_MINOR * 100 + TC9_VERSION_PATCH)

#endif /* TC9_VERSION_H */
