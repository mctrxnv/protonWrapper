{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs =
    inputs:
    inputs.flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = import inputs.nixpkgs {
          inherit
            system
            ;
        };
        lib = inputs.nixpkgs.lib;
      in
      {
        packages.default = import ./package.nix {
          inherit
            pkgs
            lib
            ;
        };
      }
    );
}
