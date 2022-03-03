{ stdenv, stepmania, makeWrapper, patches ? [], name ? "with-patch", theme ? "", buildEnv, makeDesktopItem }:

let
	stepmania-as-patch = stdenv.mkDerivation {
		name = "stepmania-without-music-at-root";
		phases = "installPhase";

		installPhase = ''
			cp -rf ${stepmania}/stepmania-* $out
			chmod +w -R $out/Songs
			rm -r $out/Songs/*
		'';
	};

	desktop = makeDesktopItem {
		name = "trotmania-${name}";
		exec = "trotmania-${name}";
		icon = "trotmania-${name}e";
		desktopName = "TrotMania (${name})";
		categories = ["Game" "ArcadeGame"];
	};
in
stdenv.mkDerivation {
	pname = "trotmania-${name}";
	version = stepmania.version;

	nativeBuildInputs = [ makeWrapper ];

	phases = [ "installPhase" ];

	installPhase = ''
		mkdir $out
		mkdir $out/trotmania
		ln -s ${buildEnv {
			name = "trotmania-${name}-buildenv";
			paths = patches ++ [ stepmania-as-patch ];
			ignoreCollisions = true;
		}}/* $out/trotmania
		rm $out/trotmania/stepmania
		cp ${stepmania}/stepmania-*/stepmania $out/trotmania/stepmania
		mkdir -p $out/bin
		makeWrapper $out/trotmania/stepmania $out/bin/trotmania-${name} \
			${if theme != "" then ''--add-flags "--theme=\"${theme}\""'' else ""}
		cp -r ${desktop}/share $out
	'';
}
