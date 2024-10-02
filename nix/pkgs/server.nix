{
  lib,
  callPackage,
  clangStdenv,
  boost,
  bzip2,
  clang,
  cmake,
  git,
  openssl,
  readline,
  zlib,
  modules ? [ ],
}:

let
  libmysqlclient = callPackage ./libmysqlclient.nix { };
  libmysqlclient-dev = callPackage ./libmysqlclient-dev.nix { };
in
clangStdenv.mkDerivation {
  name = "azerothcore-wotlk";

  src = ../../.;

  nativeBuildInputs = [ cmake ];

  patches = [ ./config_dir.patch ];

  # The name of the directory needs to have the same name as the module. It is used during linking
  postPatch = ''
    for i in ${lib.concatStringsSep " " modules};
    do
        for j in $(ls -1 $i);
        do
          ln -s $i/$j modules/
        done
    done
  '';

  buildInputs = [
    boost
    bzip2
    git
    libmysqlclient
    openssl
    readline
    zlib
  ];

  cmakeFlags = [
    "-DCMAKE_INSTALL_PREFIX=$out"
    "-DCMAKE_C_COMPILER=${clang}/bin/clang"
    "-DCMAKE_CXX_COMPILER=${clang}/bin/clang++"
    "-DWITH_WARNINGS=1"
    "-DTOOLS_BUILD=all"
    "-DSCRIPTS=static"
    "-DMODULES=static"
    "-DMYSQL_LIBRARY=${libmysqlclient}"
    "-DMYSQL_INCLUDE_DIR=${libmysqlclient-dev.dev + "/include"}"
  ];

  buildPhase = ''
    make -j$NIX_BUILD_CORES
  '';

  installPhase = ''
    make -j$NIX_BUILD_CORES install
  '';
}
