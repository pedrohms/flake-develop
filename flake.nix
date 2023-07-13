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
                nodejs
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
              name = "php";
              buildInputs = with pkgs; [
                php81Packages.composer 
                php81
                ripgrep
                fish
                nodejs-18_x
                php81Extensions.pdo_mysql
                php81Extensions.pdo_sqlite
              ];
              shellHook = "";
            };
            nodejs = pkgs.mkShell {
              name = "nodejs";
              buildInputs = with pkgs; [
                nodejs-19_x
                nodePackages_latest.pnpm
                nodePackages_latest.expo-cli
                nodePackages_latest.eas-cli
                nodePackages_latest.prisma
                openssl
                protobuf3_20
                cargo
                pkg-config
                zlib
              ];
              shellHook = "";
            };
          };
        }
      );
}

