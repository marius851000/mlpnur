{ stdenv, fetchzip }:

let
	trotmania_I = fetchzip {
		url = "https://www.mylittlekaraoke.com/trotmania/V/TrotMania.zip";
		sha256 = "/XBL2ZXoDR5vH6+QMOCtHKAX/H1vaW5VHz1bBzEKL1k=";
	};
in
	stdenv.mkDerivation {
		name = "rhythm-is-magic-data";
		phases = "installPhase";
		installPhase = ''
			mkdir -p $out/Songs
			ln -s ${trotmania_I} $out/Songs/TrotMania
		'';
	}
