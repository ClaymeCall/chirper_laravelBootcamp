{
  description = "Dev environment with Nix for Laravel Bootcamp (Chirper)";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs {
          inherit system;
          config.allowUnfree = true;
        };
      in {
        devShells.default = pkgs.mkShell {
          buildInputs = with pkgs; [
            php84
            php84Extensions.mbstring
            php84Extensions.xml
            php84Extensions.curl
            php84Extensions.opcache
            php84Extensions.pdo
            php84Extensions.pdo_sqlite

            php84Packages.composer

            nodejs_20
            yarn
            sqlite
            cacert
          ];

          # Enable Composer's global bin directory
          shellHook = ''
            export NODE_ENV=development
            export COMPOSER_HOME=$PWD/.composer
            export PATH="$COMPOSER_HOME/vendor/bin:$PATH"

            # Install Laravel installer if missing
            if [ ! -f "$COMPOSER_HOME/vendor/bin/laravel" ]; then
              echo "Installing Laravel Installer..."
              composer global require laravel/installer
            fi

            echo "Laravel dev environment loaded 🎉"
          '';
        };
      });
}

