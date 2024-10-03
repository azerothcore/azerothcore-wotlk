{
  stdenv,
  mysql84,
}:

stdenv.mkDerivation {
  pname = "libmysqlclient";
  version = mysql84.version;

  src = mysql84.src;

  buildInputs = mysql84.buildInputs;

  nativeBuildInputs = mysql84.nativeBuildInputs;

  outputs = [
    "dev"
    "out"
  ];

  cmakeFlags = [
    "-DWITHOUT_SERVER=1"
  ];
}
