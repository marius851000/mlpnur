{ pkgs ? import <nixpkgs> {}}:

let
	trotmania = pkgs.callPackage ./pkgs/trotmania/trotmania.nix {};
in rec {
	my-little-investigation = pkgs.callPackage ./pkgs/my-little-investigation {};

	trotmania-rhythm-is-magic = trotmania.override { patches = [ trotmaniaPackage.rhythm-is-magic ]; name = "rhythm-is-magic"; };

	trotmaniaPackage = {
		rhythm-is-magic = pkgs.callPackage ./pkgs/trotmania/rhythm-is-magic.nix {};

	};
}
