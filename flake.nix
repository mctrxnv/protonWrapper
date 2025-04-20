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

        wrapper = import ./package.nix {
          inherit
            pkgs
            lib
            ;
        };
      in
      {
        packages.default = pkgs.writeShellScriptBin "proton-run" (
          let
            _ = " ";
          in
          ("exec" + _ + lib.getExe pkgs.steam-run-free + _ + lib.getExe wrapper + _ + "$@")
        );
      }
    );
}
