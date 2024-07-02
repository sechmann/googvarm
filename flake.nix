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

  outputs = inputs @ {
    flake-parts,
    dream2nix,
    ...
  }:
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
        ...
      }: {
        devshells.default = {
          packages =
            (with pkgs; [
              caddy
              nodejs_22
              nodePackages.terser
              shellcheck
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
