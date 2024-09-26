{
  stdenv,
  fetchurl,
  autoPatchelfHook,
  dpkg,
}:

stdenv.mkDerivation rec {
  pname = "libmysqlclient";
  version = "8.4.2";

  src = fetchurl {
    url = "https://repo.mysql.com/apt/debian/pool/mysql-8.4-lts/m/mysql-community/libmysqlclient-dev_${version}-1debian12_amd64.deb";
    hash = "sha256-FPmoK8MfpG8lXFt9qUoR64FpTLcUAsniRT6CDn6Kb0M=";
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
    mkdir $out
    mv usr/include/mysql $out/include
    mv usr/lib/x86_64-linux-gnu/ $out/lib
    mv usr/share $out/share
  '';
}
