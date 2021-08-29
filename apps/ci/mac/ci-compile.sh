#!/usr/bin/env bash

export CCACHE_CPP2=true
export CCACHE_MAXSIZE='500M'
export CCACHE_COMPRESS=1
export CCACHE_COMPRESSLEVEL=9
ccache -s

cd var/build/obj

time cmake ../../../ \
-DTOOLS=1 \
-DBUILD_TESTING=1 \
-DSCRIPTS=static \
-DCMAKE_BUILD_TYPE=Release \
-DMYSQL_ADD_INCLUDE_PATH=/usr/local/include \
-DMYSQL_LIBRARY=/usr/local/lib/libmysqlclient.dylib \
-DREADLINE_INCLUDE_DIR=/usr/local/opt/readline/include \
-DREADLINE_LIBRARY=/usr/local/opt/readline/lib/libreadline.dylib \
-DOPENSSL_INCLUDE_DIR=/usr/local/opt/openssl/include \
-DOPENSSL_SSL_LIBRARIES=/usr/local/opt/openssl/lib/libssl.dylib \
-DOPENSSL_CRYPTO_LIBRARIES=/usr/local/opt/openssl/lib/libcrypto.dylib \
-DWITH_WARNINGS=1 \
-DCMAKE_C_FLAGS="-Werror" \
-DCMAKE_CXX_FLAGS="-Werror" \
-DCMAKE_C_COMPILER_LAUNCHER=ccache \
-DCMAKE_CXX_COMPILER_LAUNCHER=ccache \
-DUSE_SCRIPTPCH=0 \
-DUSE_COREPCH=0 \
;

time make -j $(($(sysctl -n hw.ncpu ) + 2))

ccache -s
