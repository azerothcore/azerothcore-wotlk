{
  description = "Complete Open Source and Modular solution for MMO";

  inputs = {
    flake-parts.url = "github:hercules-ci/flake-parts";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = inputs@{ flake-parts, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems =
        [ "x86_64-linux" "aarch64-linux" "aarch64-darwin" "x86_64-darwin" ];
      perSystem = { config, self', inputs', pkgs, system, ... }: {
        devShells = {
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
    };
}
