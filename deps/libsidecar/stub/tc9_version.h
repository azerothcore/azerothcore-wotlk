#ifndef TC9_VERSION_H
#define TC9_VERSION_H

/* Vendored snapshot of libsidecar-cpp generated version header.
 * Keep in sync with include/tc9_version.h and the linked libsidecar binary.
 * Built only when USE_REAL_LIBSIDECAR is OFF (static stub, not the real .so/.dll).
 */

#define TC9_LIBSIDECAR_IS_STUB 1

#define TC9_VERSION_MAJOR 1
#define TC9_VERSION_MINOR 0
#define TC9_VERSION_PATCH 0

#define TC9_VERSION_STRING "1.0.0"

/* major*10000 + minor*100 + patch */
#define TC9_VERSION_NUMBER \
    (TC9_VERSION_MAJOR * 10000 + TC9_VERSION_MINOR * 100 + TC9_VERSION_PATCH)

#endif /* TC9_VERSION_H */
