{ pkgs ? import <nixpkgs> {}}:

let
	trotmania = pkgs.callPackage ./pkgs/trotmania/trotmania.nix {};
in rec {
	# tool
	fetchmega = pkgs.callPackage ./pkgs/tool/fetchmega.nix {};

	my-little-investigation = pkgs.callPackage ./pkgs/my-little-investigation {};

	trotmania-rhythm-is-magic = trotmania.override { patches = [ trotmaniaPackage.rhythm-is-magic ]; name = "rhythm-is-magic"; };

	trotmania-chrystalize = trotmania.override { patches = [ trotmaniaPackage.chrystalize ]; name = "chrystalize"; };

	trotmania-aeternum-obscurum = trotmania.override { patches = [ trotmaniaPackage.aeternum-obscurum  ]; name = "aeternum-obscurum"; theme = "TrotMania3"; };


	trotmaniaPackage = {
		rhythm-is-magic = pkgs.callPackage ./pkgs/trotmania/rhythm-is-magic.nix {};

		chrystalize = pkgs.callPackage ./pkgs/trotmania/chrystalize.nix {};

		aeternum-obscurum = pkgs.callPackage ./pkgs/trotmania/aeternum-obscurum.nix { inherit fetchmega; };
	};
}
