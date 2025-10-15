# Flakes
Collection of Nix Flakes used in research projects

Use by adding the following to your .envrc
```
use flake "github:PaulPyl/Flakes?dir=<some_directory_from_this_repo>"
```

`some_directory_from_this_repo` should be one of the flakes defining project environments here, e.g. `SingleCell`

## Composite Flakes

Sometime one might want to combine different environment from here, an example of how to achieve this is given in `scAnalysis` which has a `flake.nix` file in it that combines the `SingleCell` and `Tidyverse` flake from this repository.
There is also a `.envrc` file provided there which simply loads the flake from the local directory, so that only makes sense when the scAnalysis `flake.nix` file is locally stored on your computer, but you should also be able to have a `.envrc` file that looks like this:

```
use flake "github:PaulPyl/Flakes?dir=scAnalysis"
```