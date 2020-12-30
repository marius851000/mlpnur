{ pkgs ? import <nixpkgs> {}}:

let
	trotmania = pkgs.callPackage ./pkgs/trotmania/trotmania.nix {};
in rec {
	# tool
	fetchmega = pkgs.callPackage ./pkgs/tool/fetchmega.nix {};

	# games
	my-little-investigation = pkgs.callPackage ./pkgs/my-little-investigation {};

	trotmania-rhythm-is-magic = trotmania.override { patches = [ trotmaniaPackage.rhythm-is-magic ]; name = "rhythm-is-magic"; };

	trotmania-chrystalize = trotmania.override { patches = [ trotmaniaPackage.chrystalize ]; name = "chrystalize"; };

	trotmania-aeternum-obscurum = trotmania.override { patches = [ trotmaniaPackage.aeternum-obscurum  ]; name = "aeternum-obscurum"; theme = "TrotMania3"; };

	trotmania-euphorius = trotmania.override { patches = [ trotmaniaPackage.euphorius  ]; name = "euphorius"; theme = "TM Euphorius"; };

	trotmania-shrive = trotmania.override { patches = [ trotmaniaPackage.shrive ]; name = "shrive"; theme = "TM V"; };

	trotmania-full = trotmania.override { patches = with trotmaniaPackage; [
		rhythm-is-magic
		chrystalize
		aeternum-obscurum
		euphorius
		shrive
	]; name = "full"; };

	trotmaniaPackage = rec {
		qol_full = pkgs.callPackage ./pkgs/trotmania/qol.nix { inherit fetchmega; };

		course_full = pkgs.callPackage ./pkgs/trotmania/course.nix { inherit fetchmega; };

		rhythm-is-magic = pkgs.callPackage ./pkgs/trotmania/rhythm-is-magic.nix { inherit qol_full course_full; };

		chrystalize = pkgs.callPackage ./pkgs/trotmania/chrystalize.nix { inherit qol_full course_full; };

		aeternum-obscurum = pkgs.callPackage ./pkgs/trotmania/aeternum-obscurum.nix { inherit fetchmega qol_full course_full; };

		euphorius = pkgs.callPackage ./pkgs/trotmania/euphorius.nix { inherit fetchmega qol_full course_full; };

		shrive = pkgs.callPackage ./pkgs/trotmania/shrive.nix { inherit fetchmega qol_full course_full; };
	};

	my-little-karaoke = pkgs.callPackage ./pkgs/my-little-karaoke/default.nix { beta = false; };

	my-little-karaoke-beta = pkgs.callPackage ./pkgs/my-little-karaoke/default.nix { beta = true; };

	patapony = pkgs.callPackage ./pkgs/patapony/patapony.nix {};
}
