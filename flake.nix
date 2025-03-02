{
  description = "Flake to export Emacs package";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    flake-utils.url = "github:numtide/flake-utils";
    emacs-overlay.url = "github:nix-community/emacs-overlay";
  };

  outputs = {self, nixpkgs, flake-utils, emacs-overlay}:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = (import nixpkgs) {
          inherit system;
          overlays = [ emacs-overlay.overlay ];
        };
      in rec {
        defaultPackage = packages.${system};

        packages.${system} = (pkgs.emacsWithPackagesFromUsePackage {
          config = ./emacs.el;
          defaultInitFile = true;
          package = pkgs.emacs-git;
          extraEmacsPackages = epkgs: [
            pkgs.fzf
            pkgs.texliveBasic
          ];
        });
      }
    );
}
