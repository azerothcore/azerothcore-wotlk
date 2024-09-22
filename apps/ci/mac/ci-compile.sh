#!/usr/bin/env bash

export OPENSSL_ROOT_DIR=$(brew --prefix openssl@3)

export CCACHE_CPP2=true
export CCACHE_MAXSIZE='500M'
export CCACHE_COMPRESS=1
export CCACHE_COMPRESSLEVEL=9
ccache -s

cd var/build/obj

mysql_include_path=$(brew --prefix mysql)/include/mysql
mysql_lib_path=$(brew --prefix mysql)/lib/libmysqlclient.dylib

if [ ! -d "$mysql_include_path" ]; then
    echo "Original mysql include directory doesn't exist. Lets try to use the first available folder in mysql dir."
    base_dir=$(brew --cellar mysql)/$(basename $(ls -d $(brew --cellar mysql)/*/ | head -n 1))
    echo "Trying the next mysql base dir: $base_dir"
    mysql_include_path=$base_dir/include/mysql
    mysql_lib_path=$base_dir/lib/libmysqlclient.dylib
fi

time cmake ../../../ \
-DTOOLS_BUILD=all \
-DSCRIPTS=static \
-DCMAKE_BUILD_TYPE=Release \
-DMYSQL_ADD_INCLUDE_PATH=$mysql_include_path \
-DMYSQL_LIBRARY=$mysql_lib_path \
-DREADLINE_INCLUDE_DIR=$(brew --prefix readline)/include \
-DREADLINE_LIBRARY=$(brew --prefix readline)/lib/libreadline.dylib \
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
