{
  description = "A development shell for omics integration analyses using R with tidyverse added in";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    tidyverse.url  = "github:PaulPyl/Flakes?dir=Tidyverse"; # We will pull in the tidyverse set of packages directly here
  };

  outputs = { self, nixpkgs, flake-utils, tidyverse, ... }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};

        # Define the specific R packages you want
        rPackages = with pkgs.rPackages; [
          # Base R packages are often included, but we specify the extra ones
          # Note: Nix handles dependencies, so you typically just list the top-level packages.
          mixOmics
          MOFA2
        ];

      in {
        # Define the development shell

        devShells.default = pkgs.mkShell {
          inputsFrom = [
            # Compose the default devShell from the Tidyverse flake
            tidyverse.devShells.${system}.default
          ];

          packages = [
            # Base R interpreter
            pkgs.R
            # The specified R packages (and their dependencies)
          ] ++ rPackages;
        };
      });
}
