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
                sumneko-lua-language-server
                maven
                jdk  
              ];
              shellHook = "";
            };
            python2 = pkgs.mkShell {
              name = "nix2";
              buildInputs = with pkgs; [
                python2
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
            }
          };
        }
      );
}

