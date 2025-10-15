{
  description = "Project combining SingleCell and Tidyverse environments using flake-utils for a single-cell analysis environment.";

  inputs = {
    # 1. Nixpkgs input
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable"; # Use unstable

    # 2. Flake-Utils input
    flake-utils.url = "github:numtide/flake-utils";

    # 3. Your custom flake inputs
    singlecell.url = "github:PaulPyl/Flakes?dir=SingleCell";
    tidyverse.url  = "github:PaulPyl/Flakes?dir=Tidyverse";
  };

  outputs = { self, nixpkgs, flake-utils, singlecell, tidyverse, ... }:
    # Use eachDefaultSystem to define outputs for common systems (x86_64-linux, aarch64-darwin, etc.)
    flake-utils.lib.eachDefaultSystem (system:
      let
        # Import the correct nixpkgs set for the current system
        pkgs = nixpkgs.legacyPackages.${system};
      in
      {
        # Define the default devShell for this system
        devShells.default = pkgs.mkShell {
          inputsFrom = [
            # Compose the default devShell from the SingleCell flake
            singlecell.devShells.${system}.default

            # Compose the default devShell from the Tidyverse flake
            tidyverse.devShells.${system}.default
          ];
        };
      }
    );
}
