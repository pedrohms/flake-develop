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
            python2 = pkgs.mkShell {
              name = "python2";
              buildInputs = with pkgs; [
                python2
              ];
              shellHook = "";
            };
            python3 = pkgs.mkShell {
              name = "python3";
              buildInputs = with pkgs; [
                python3
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
                bun
              ];
              shellHook = "";
            };
          };
        }
      );
}

