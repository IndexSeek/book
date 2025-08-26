{
  description = "Data Wrangling with Ibis - A comprehensive guide to expressive analytics at any scale.";

  inputs = {
    flake-utils.url = "github:numtide/flake-utils";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = { self, flake-utils, nixpkgs, ... }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };
        python = pkgs.python313;
      in {
        devShells.default = pkgs.mkShell {
          buildInputs = with pkgs; [
            python
            python313Packages.ipython
            uv
            pre-commit
            quarto
            graphviz-nox
            docker-compose
            texliveFull
            git
            just
          ];
          shellHook = ''
            uv sync --quiet
            export QUARTO_PYTHON=$(uv run which python)
            if [ -f .pre-commit-config.yaml ]; then
              pre-commit install --install-hooks >/dev/null 2>&1 || true
            fi
          '';
        };
      }
    );
}
