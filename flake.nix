{
  description = "Complete Open Source and Modular solution for MMO";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

  outputs =
    { self, nixpkgs, ... }@attrs:
    let
      supportedSystems = [
        "x86_64-linux"
        "aarch64-linux"
      ];

      forAllSystems = nixpkgs.lib.genAttrs supportedSystems;
      nixpkgsFor = forAllSystems (system: import nixpkgs { inherit system; });
    in
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

          serverSrc = pkgs.stdenv.mkDerivation {
            name = "azerothcore-wotlk-source";

            src = ./.;

            dontBuild = true;
            dontConfigure = true;

            installPhase = ''
              mkdir -p $out
              cp -R $src/* $out/
            '';
          };

          serverData = pkgs.stdenv.mkDerivation {
            pname = "wow-server-data";
            version = "16";

            src = pkgs.fetchurl {
              url = "https://github.com/wowgaming/client-data/releases/download/v16/data.zip";
              hash = "sha256-zM5sdqJekI/HKf6fcRZYcb0PUzTSSvuwL0DvsT08fek=";
            };

            dontBuild = true;
            dontConfigure = true;
            dontPatch = true;
            dontFix = true;

            nativeBuildInputs = [ pkgs.unzip ];

            unpackPhase = ''
              runHook preUnpack

              unzip $src

              runHook postUnpack
            '';

            installPhase = ''
              mkdir $out
              cp -rv * $out/
              rm -f $out/*.zip
            '';
          };

          serverWithEluna = server.override {
            modules = [
              (mkModulePackage "azerothcore" "mod-eluna" "c652ee8e1a8dea6e4ee54ed5dc93837aca6f2ddc"
                "sha256-vXtihngtkWcZG/ZHaRxgSfXMHDx2jofJg0GiAh673Jk="
              )
            ];
          };

          server = pkgs.callPackage ./nix/pkgs/server.nix { };
        };

      overlays = forAllSystems (system: {
        default = (
          final: prev: {
            azerothcore-wotlk-server = self.packages.${system}.server;
            azerothcore-wotlk-server-eluna = self.packages.${system}.serverWithEluna;
            azerothcore-wotlk-data = self.packages.${system}.serverData;
            azerothcore-wotlk-source = self.packages.${system}.serverSrc;
          }
        );
      });

      devShells = forAllSystems (
        system:
        let
          pkgs = nixpkgsFor.${system};

          libmysqlclient = pkgs.callPackage ./nix/pkgs/libmysqlclient.nix { };
        in
        {
          default = pkgs.mkShell.override { stdenv = pkgs.clangStdenv; } {
            buildInputs = with pkgs; [
              boost
              bzip2
              cmake
              libmysqlclient
              openssl
              readline
              zlib
            ];

            MYSQL_INCLUDE_DIR = libmysqlclient.dev + "/include";
          };
        }
      );

      nixosConfigurations.test =
        let
          system = "x86_64-linux";
        in
        nixpkgs.lib.nixosSystem rec {
          inherit system;
          pkgs = import nixpkgs {
            inherit system;
            overlays = [ self.overlays.${system}.default ];
          };
          modules = [
            self.nixosModules.default
            ./nix/configurations/test.nix
          ];
        };

      nixosModules.default = import ./nix/modules/default.nix;
    };
}
