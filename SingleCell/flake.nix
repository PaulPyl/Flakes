{
  description = "A development shell for R with Seurat and SingleCellExperiment";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    flake-utils.url = "github.com/numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};

        # Define the specific R packages you want
        rPackages = with pkgs.rPackages; [
          # Base R packages are often included, but we specify the extra ones
          # Note: Nix handles dependencies, so you typically just list the top-level packages.
          seurat
          singleCellExperiment
        ];

      in {
        # Define the development shell
        devShells.default = pkgs.mkShell {
          name = "r-seurat-sce-shell";

          # List the packages to include in the shell environment
          packages = [
            # Base R interpreter
            pkgs.r
            # The specified R packages (and their dependencies)
          ] ++ rPackages;

          # Optional: Define environment variables for R/RStudio if needed
          # shellHook = ''
          #   echo "Welcome to the R development shell!"
          #   # For example, setting an environment variable
          #   export MY_R_VAR="NixShell"
          # '';
        };
      });
}
