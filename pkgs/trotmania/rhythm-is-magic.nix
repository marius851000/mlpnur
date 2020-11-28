{ stdenv, fetchzip, qol_full, buildEnv, course_full }:

let
	trotmania_I = fetchzip {
		url = "https://www.mylittlekaraoke.com/trotmania/V/TrotMania.zip";
		sha256 = "/XBL2ZXoDR5vH6+QMOCtHKAX/H1vaW5VHz1bBzEKL1k=";
	};

	qol_rhythm-is-magic = stdenv.mkDerivation {
		name = "qol-rhythm-is-magic";
		phases = "installPhase";
		installPhase = ''
			mkdir -p $out/Songs
			ln -s ${qol_full}/Songs/TrotMania $out/Songs/TrotMania
		'';
	};
	course = stdenv.mkDerivation {
		name = "rhythm-is-magic-course";
		phases = "installPhase";
		installPhase = ''
			mkdir -p $out/Courses
			ln -s ${course_full}/Courses/TrotMania $out/Courses/TrotMania
		'';
	};
	music = stdenv.mkDerivation {
		name = "rhythm-is-magic-music";
		phases = "installPhase";
		installPhase = ''
			mkdir -p $out/Songs
			ln -s ${trotmania_I} $out/Songs/TrotMania
		'';
	};
	data = buildEnv {
		name = "rhythm-is-magic-datat";
		paths = [ music course ];
	};
in
	buildEnv {
		name = "rhythm-is-magic-patched";
		paths = [ qol_rhythm-is-magic data ];
		ignoreCollisions = true;
	}
