{ stdenv, stepmania, makeWrapper, patches ? [], name ? "with-patch", theme ? "", buildEnv }:

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
		${if theme == "" then
			"ln -s $out/trotmania/stepmania $out/bin/trotmania-${name}"
		else ''
			makeWrapper $out/trotmania/stepmania $out/bin/trotmania-${name} \
				--add-flags "--theme=\"${theme}\""
		''}
	'';
}
