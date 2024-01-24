{
  description = "A flake using poetry2nix";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/e5f115b0d44039f10dde3bb855d40bf9668fa618";
    utils.url = "github:numtide/flake-utils";
    poetry2nix = {
      url = "github:nix-community/poetry2nix/e0b44e9e2d3aa855d1dd77b06f067cd0e0c3860d";
      };
  };
  outputs = {nixpkgs, utils, self, poetry2nix}:
    utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs {
          inherit system;
          overlays = [poetry2nix.overlays.default];
        };
        poetryEnv = pkgs.poetry2nix.mkPoetryEnv {
          projectDir = ./.;
        };
      in {
        devShell = pkgs.mkShell {
          buildInputs = [ poetryEnv ];
      };
    }
  );
}

