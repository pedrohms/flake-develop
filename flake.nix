{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    android-nixpkgs.url = "github:tadfisher/android-nixpkgs";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-23.05";
  };
  outputs = { self, nixpkgs, flake-utils, android-nixpkgs, nixpkgs-stable }:
  let
    version = "1.2.1";
  in
    flake-utils.lib.eachDefaultSystem
      (system:
        let
          pkgs = import nixpkgs {
            inherit system;
            config = {
              android_sdk.accept_license = true;
              allowUnfree = true;
            };
          };
          androidSdk = android-nixpkgs.sdk.${system} (sdkPkgs: with sdkPkgs; [
            cmdline-tools-latest
            build-tools-30-0-3
            build-tools-33-0-2
            build-tools-34-0-0
            platform-tools
            emulator
            patcher-v4
            platforms-android-30
            platforms-android-31
            platforms-android-33
            system-images-android-32-google-apis-x86-64
          ]);
          pinnedJDK = pkgs.jdk17;
        in
        {
          devShells = {
            default = pkgs.mkShell {
              name = "nix";
              buildInputs = with pkgs; [
                nodejs_20
                go
                delve
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
                nodejs_20
                nodePackages_latest.pnpm
                nodePackages_latest.prisma
                openssl
                protobuf3_20
                cargo
                pkg-config
                zlib
                kotlin
                jetbrains.idea-community
              ];
              shellHook = "";
            };
            jdk21 = pkgs.mkShell {
              name = "jdk";
              buildInputs = with pkgs; [
                jdk21
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
                nodejs_20
                nodePackages_latest.pnpm
                nodePackages_latest.prisma
                openssl
                protobuf3_20
                cargo
                pkg-config
                zlib
                kotlin
                kotlin-language-server
              ];
              shellHook = "";
              KOTLIN_LSP_HOME = "${pkgs.kotlin-language-server}";
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
              name = "php83";
              buildInputs = with pkgs; [
                php83Packages.composer 
                php83
                ripgrep
                fish
                nodejs_20
                phpactor
                nodePackages_latest.pnpm
                nodePackages_latest.prisma
                php83Extensions.pdo_mysql
                php83Extensions.pdo_sqlite
                php83Extensions.xdebug
                php83Extensions.redis
                vscode-extensions.devsense.profiler-php-vscode
              ];
              XDEBUG_MODE = "debug";
              shellHook = ''
                export PHPACTOR_PATH=${pkgs.phpactor}
              '';
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
            flutter = pkgs.mkShell rec {
              name = "flutter";
              buildInputs = with pkgs; [
                androidSdk
                pinnedJDK
                gitlint
                nodejs_20
                openssl
                protobuf3_20
                cargo
                pkg-config
                zlib
                dart
                at-spi2-core.dev
                clang
                cmake
                # dart
                dbus.dev
                flutter
                gtk3
                libdatrie
                libepoxy.dev
                libselinux
                libsepol
                libthai
                libxkbcommon
                ninja
                pcre
                pkg-config
                util-linux.dev
                xorg.libXdmcp
                xorg.libXtst
              ];
              # Make Flutter build on desktop
              CPATH = "${pkgs.xorg.libX11.dev}/include:${pkgs.xorg.xorgproto}/include";
              LD_LIBRARY_PATH = with pkgs; lib.makeLibraryPath [ atk cairo epoxy gdk-pixbuf glib gtk3 harfbuzz pango ];
              
              ANDROID_HOME = "${androidSdk}/share/android-sdk";
              ANDROID_SDK_ROOT = "${androidSdk}/share/android-sdk";
              JAVA_HOME = pinnedJDK;

              # Fix an issue with Flutter using an older version of aapt2, which does not know
              # an used parameter.
              GRADLE_OPTS = "-Dorg.gradle.project.android.aapt2FromMavenOverride=${androidSdk}/share/android-sdk/build-tools/34.0.0/aapt2";
              GRADLE_USER_HOME = "/home/framework/.gradle";
              DART_PATH = "${pkgs.flutter}";
              FLUTTER_PATH = "${pkgs.flutter}";
            };
            cpp = pkgs.mkShell rec {
              name = "cpp";
              buildInputs = with pkgs; [
                clang
                cmake
                gnumake
                xorg.libX11 xorg.libXinerama xorg.libXft 
                autogen
                zlib zlib.dev
                libcxx
                libclang
                pkg-config
                libmysqlclient
                gdb
                vscode-extensions.vadimcn.vscode-lldb
                gf
                wxGTK32
                cmakeWithGui
                gtk4
              ];
              LD_LIBRARY_PATH = with pkgs; lib.makeLibraryPath [ libmysqlclient ];
              MYSQL_PATH = "${pkgs.libmysqlclient}/lib/mariadb";
              WX_PATH = "${pkgs.wxGTK32}";
              GTK4_PKG = "${pkgs.gtk4}";
              LLDB_PATH = "${pkgs.vscode-extensions.vadimcn.vscode-lldb}/share/vscode/extensions/vadimcn.vscode-lldb/adapter";
            };
            gcc = (pkgs.buildFHSEnv {
              name = "gcc";
              targetPkgs = pkgs: with pkgs; [
                gcc
                clang
                cmake
                gnumake
                stdenv.cc
                stdenv.cc.libc stdenv.cc.libc_dev
                # git checkout need flex as they are not complete release tarballs
                # m4
                # bison
                # flex
                # texinfo
                # test harness
                xorg.libX11 xorg.libXinerama xorg.libXft 
                dejagnu
                autogen
                zlib zlib.dev
                libcxx
                pkg-config
                libmysqlclient
              ];
              runScript = "fish";
            }).env;
            dotnet = pkgs.mkShell {
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
                dotnet-sdk_8
              ];
            };
          };
        }
      );
}

