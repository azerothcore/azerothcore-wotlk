{
  lib,
  clangStdenv,
  boost,
  clang,
  cmake,
  openssl,
  libmysqlclient,
  readline,
  bzip2,
  git,
  modules ? [ ],
}:

clangStdenv.mkDerivation {
  name = "azerothcore-wotlk";

  src = ../../.;

  nativeBuildInputs = [ cmake ];

  # The name of the directory needs to have the same name as the module it's used when linking
  patchPhase = ''
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
    openssl
    libmysqlclient
    readline
    bzip2
    git
  ];

  configurePhase = ''
    mkdir build $out
    cd build
    cmake ../ -DCMAKE_INSTALL_PREFIX=$out -DCMAKE_C_COMPILER=${clang}/bin/clang -DCMAKE_CXX_COMPILER=${clang}/bin/clang++ -DWITH_WARNINGS=1 -DTOOLS_BUILD=all -DSCRIPTS=static -DMODULES=static -DMYSQL_INCLUDE_DIR=${
      libmysqlclient.dev + "/include/mysql"
    }
  '';

  buildPhase = ''
    make -j$NIX_BUILD_CORES
  '';

  installPhase = ''
    make -j$NIX_BUILD_CORES install
  '';
}
