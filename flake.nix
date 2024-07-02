{
  description = "Complete Open Source and Modular solution for MMO";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

  outputs =
    { self, nixpkgs, ... }@attrs:
    {
      packages.x86_64-linux =
        let
          pkgs = import nixpkgs { system = "x86_64-linux"; };

          mkModulePackage =
            owner: repo: rev: hash:
            pkgs.stdenv.mkDerivation {
              name = repo;
              src = pkgs.fetchFromGitHub {
                inherit
                  owner
                  repo
                  rev
                  hash
                  ;
              };

              dontBuild = true;
              dontConfigure = true;
              installPhase = ''
                mkdir -p $out/${repo}
                cp -R $src/* $out/${repo}
              '';
            };
        in
        rec {
          default = server;

          serverWithEluna = server.override {
            modules = [
              (mkModulePackage "azerothcore" "mod-eluna" "c652ee8e1a8dea6e4ee54ed5dc93837aca6f2ddc"
                "sha256-vXtihngtkWcZG/ZHaRxgSfXMHDx2jofJg0GiAh673Jk="
              )
            ];
          };

          server = pkgs.callPackage ./nix/pkgs/server.nix { };
        };

      devShells.x86_64-linux =
        let
          pkgs = import nixpkgs { system = "x86_64-linux"; };
        in
        {
          default = pkgs.mkShell.override { stdenv = pkgs.clangStdenv; } {
            nativeBuildInputs = with pkgs; [
              boost
              cmake
              openssl
              libmysqlclient
              readline
              bzip2
            ];

            MYSQL_INCLUDE_DIR = pkgs.libmysqlclient.dev + "/include/mysql";
          };
        };
    };
}
