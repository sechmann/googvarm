{
  description = "Go' og Varm web";

  inputs = {
    dream2nix.url = "github:nix-community/dream2nix";
    nixpkgs.follows = "dream2nix/nixpkgs";
    flake-parts.url = "github:hercules-ci/flake-parts";
    flake-root.url = "github:srid/flake-root";
    devshell.url = "github:numtide/devshell";
    treefmt-nix.url = "github:numtide/treefmt-nix";
  };

  outputs = inputs @ {flake-parts, ...}:
    flake-parts.lib.mkFlake {inherit inputs;} {
      imports = [inputs.flake-root.flakeModule inputs.treefmt-nix.flakeModule inputs.devshell.flakeModule];
      systems = [
        "x86_64-linux"
        "aarch64-linux"
        "aarch64-darwin"
        "x86_64-darwin"
      ];

      perSystem = {
        pkgs,
        config,
        system,
        ...
      }: {
        _module.args.pkgs = import inputs.nixpkgs {
          inherit system;
          overlays = [
            (final: prev: {
              go = prev.go.overrideAttrs (_old: {
                version = "1.22.5";
                src = prev.fetchurl {
                  url = "https://go.dev/dl/go1.22.5.src.tar.gz";
                  hash = "sha256-rJxyPyJJaa7mJLw0/TTJ4T8qIS11xxyAfeZEu0bhEvY=";
                };
              });
            })
          ];
        };
        devshells.default = {
          packages =
            (with pkgs; [
              caddy
              gcc # needed for sqlite3-go
              gnumake
              go
              go-tools
              gopls
              gotools
              imagemagick
              nodePackages.terser
              nodejs_22
              protobuf
              shellcheck
              sqlite-interactive # -interactive gives readline / ncurses
            ])
            ++ (with pkgs.elmPackages; [
              elm
              elm-doc-preview
              elm-format
              elm-optimize-level-2
              elm-test
            ])
            ++ [config.treefmt.build.wrapper];
        };

        treefmt.config = {
          inherit (config.flake-root) projectRootFile;
          package = pkgs.treefmt;

          programs = {
            alejandra.enable = true;
            deadnix.enable = true;
            gofumpt.enable = true;
            prettier.enable = true;
            statix.enable = true;
          };
        };
      };
    };
}
