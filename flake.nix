{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };
  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem
      (system:
        let pkgs = nixpkgs.legacyPackages.${system}; in
        {
          devShells = {
            default = pkgs.mkShell {
              name = "nix";
              buildInputs = with pkgs; [
                nodejs_20
                go
                python3
                maven
                jdk  
                google-java-format
                sumneko-lua-language-server
              ];
              shellHook = "";
            };
            jdk = pkgs.mkShell {
              name = "jdk";
              buildInputs = with pkgs; [
                jdk
                maven
                gradle
                google-java-format
              ];
              shellHook = "";
            };
            jdk17 = pkgs.mkShell {
              name = "jdk17";
              buildInputs = with pkgs; [
                jdk17
                maven
                gradle
                google-java-format
              ];
              shellHook = "";
            };
            jdk11 = pkgs.mkShell {
              name = "jdk11";
              buildInputs = with pkgs; [
                jdk11
                maven
                gradle
                google-java-format
              ];
              shellHook = "";
            };
            jdk8 = pkgs.mkShell {
              name = "jdk8";
              buildInputs = with pkgs; [
                jdk8_headless
                maven
                gradle
                google-java-format
              ];
              shellHook = "";
            };
            python = pkgs.mkShell {
              name = "python3";
              buildInputs = with pkgs; [
                python3
                poetry
                nodejs_20
              ];
              shellHook = "";
            };
            php = pkgs.mkShell {
              name = "php82";
              buildInputs = with pkgs; [
                php82Packages.composer 
                php82
                ripgrep
                fish
                nodejs_20
                nodePackages_latest.pnpm
                nodePackages_latest.prisma
                php82Extensions.pdo_mysql
                php82Extensions.pdo_sqlite
              ];
              shellHook = "";
            };
            nodejs = pkgs.mkShell {
              name = "nodejs";
              buildInputs = with pkgs; [
                nodejs_20
                nodePackages_latest.pnpm
                nodePackages_latest.prisma
                openssl
                protobuf3_20
                cargo
                pkg-config
                zlib
              ];
              shellHook = "";
            };
            bun = pkgs.mkShell {
              name = "bun";
              buildInputs = with pkgs; [
                nodejs_20
                nodePackages_latest.pnpm
                nodePackages_latest.prisma
                openssl
                protobuf3_20
                cargo
                pkg-config
                zlib
                bun
              ];
            };
            gcc = pkgs.mkShell {
              name = "gcc";
              buildInputs = with pkgs; [
                gcc
                cmake
                gnumake
                stdenv.cc
                stdenv.cc.libc stdenv.cc.libc_dev
                # git checkout need flex as they are not complete release tarballs
                m4
                bison
                flex
                texinfo
                # test harness
                dejagnu
                autogen
                zlib zlib.dev
              ];
              shellHook = "";
            };
          };
        }
      );
}

