{
  stdenv,
  fetchurl,
  autoPatchelfHook,
  dpkg,
}:

stdenv.mkDerivation rec {
  pname = "libmysqlclient-dev";
  version = "8.0.39-0ubuntu0.24.04.1";

  src = fetchurl {
    url = "http://security.ubuntu.com/ubuntu/pool/main/m/mysql-8.0/libmysqlclient-dev_${version}_amd64.deb";
    hash = "sha256-0JAYOucRHufJPrxGnYaOczV1OEtoeNhFU1xvVogaAGw=";
  };

  unpackPhase = ''
    dpkg -x $src .
  '';

  nativeBuildInputs = [
    autoPatchelfHook
    dpkg
  ];

  outputs = [
    "out"
    "dev"
  ];

  installPhase = ''
    mkdir - $dev $out $out/bin
    mv usr/bin/mysql_config $out/bin
    mv usr/lib/x86_64-linux-gnu/ $out/lib
    mv usr/share $out/share
    mv usr/include/mysql $dev/include
    ln -s $dev/include $dev/include/mysql
  '';
}
