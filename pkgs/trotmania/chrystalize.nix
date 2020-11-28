{ qol_full, fetchzip, stdenv, buildEnv }:
let
	src = fetchzip {
		url = "https://www.mylittlekaraoke.com/trotmania/V/TrotMania%20Chrystalize-003.zip";
		sha256 = "gE0Hw41ZSDzo99EPEwQgioMQONcyXFtK6I1LHWbKsog=";
	};

	qol_chrystalize = stdenv.mkDerivation {
		name = "qol-chrystalize";
		phases = "installPhase";
		installPhase = ''
			mkdir -p $out/Songs
			ln -s ${qol_full}/Songs/TrotMania\ Chrystalize $out/Songs/TrotMania\ Chrystalize
		'';
	};

	music = stdenv.mkDerivation {
		name = "chrystalize-data";
		phases = [ "installPhase" ];
		installPhase = ''
			mkdir -p $out/Songs
			ln -s ${src} $out/Songs/TrotMania\ Chrystalize
		'';
	};
in
	buildEnv {
		name = "chrystalize-payched";
		paths = [ qol_chrystalize music ];
		ignoreCollisions = true;
	}
