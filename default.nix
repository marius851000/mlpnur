{ pkgs ? import <nixpkgs> {}}:

let
	trotmania = pkgs.callPackage ./pkgs/trotmania/trotmania.nix {};
in rec {
	my-little-investigation = pkgs.callPackage ./pkgs/my-little-investigation {};

	trotmania-rhythm-is-magic = trotmania.override { patches = [ trotmaniaPackage.rhythm-is-magic ]; name = "rhythm-is-magic"; };

	trotmania-chrystalize = trotmania.override { patches = [ trotmaniaPackage.chrystalize ]; name = "chrystalize"; };


	trotmaniaPackage = {
		rhythm-is-magic = pkgs.callPackage ./pkgs/trotmania/rhythm-is-magic.nix {};

		chrystalize = pkgs.callPackage ./pkgs/trotmania/chrystalize.nix {};
	};
}
