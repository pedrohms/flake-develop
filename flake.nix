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
              ];
              shellHook = "";
            };
            jdk = pkgs.mkShell {
              name = "jdk";
              buildInputs = with pkgs; [
                jdk
                maven
                gradle
              ];
              shellHook = "";
            };
            jdk17 = pkgs.mkShell {
              name = "jdk17";
              buildInputs = with pkgs; [
                jdk17
                maven
                gradle
              ];
              shellHook = "";
            };
            jdk11 = pkgs.mkShell {
              name = "jdk11";
              buildInputs = with pkgs; [
                jdk11
                maven
                gradle
              ];
              shellHook = "";
            };
            jdk8 = pkgs.mkShell {
              name = "jdk8";
              buildInputs = with pkgs; [
                jdk8_headless
                maven
                gradle
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
              ];
              shellHook = "";
            };
          };
        }
      );
}

