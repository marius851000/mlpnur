{ stdenv, stepmania, patches ? [], name ? "with-patch", buildEnv }:

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
in
stdenv.mkDerivation {
	pname = "trotmania-${name}";
	version = stepmania.version;

	phases = [ "installPhase" ];

	installPhase = ''
		mkdir $out
		mkdir $out/trotmania
		ln -s ${buildEnv {
			paths = [ stepmania-as-patch ] ++ patches;
			name = "trotmania-${name}-buildenv";
		}}/* $out/trotmania
		rm $out/trotmania/stepmania
		cp ${stepmania}/stepmania-*/stepmania $out/trotmania/stepmania
		mkdir -p $out/bin
		ln -s $out/trotmania/stepmania $out/bin/trotmania-${name}
	'';
}
