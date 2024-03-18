#!/usr/bin/env bash

export OPENSSL_ROOT_DIR=$(brew --prefix openssl@3)

export CCACHE_CPP2=true
export CCACHE_MAXSIZE='500M'
export CCACHE_COMPRESS=1
export CCACHE_COMPRESSLEVEL=9
ccache -s

cd var/build/obj

time cmake ../../../ \
-DTOOLS_BUILD=all \
-DSCRIPTS=static \
-DCMAKE_BUILD_TYPE=Release \
-DMYSQL_ADD_INCLUDE_PATH=/usr/local/include \
-DMYSQL_LIBRARY=/usr/local/lib/libmysqlclient.dylib \
-DREADLINE_INCLUDE_DIR=/usr/local/opt/readline/include \
-DREADLINE_LIBRARY=/usr/local/opt/readline/lib/libreadline.dylib \
-DOPENSSL_INCLUDE_DIR="$OPENSSL_ROOT_DIR/include" \
-DOPENSSL_SSL_LIBRARIES="$OPENSSL_ROOT_DIR/lib/libssl.dylib" \
-DOPENSSL_CRYPTO_LIBRARIES="$OPENSSL_ROOT_DIR/lib/libcrypto.dylib" \
-DCMAKE_C_COMPILER_LAUNCHER=ccache \
-DCMAKE_CXX_COMPILER_LAUNCHER=ccache \
-DUSE_SCRIPTPCH=0 \
-DUSE_COREPCH=0 \
;

time make -j $(($(sysctl -n hw.ncpu ) + 2))

ccache -s
