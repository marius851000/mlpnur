{ qol_full, fetchzip, stdenv, buildEnv, course_full }:
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
		name = "chrystalize-music";
		phases = [ "installPhase" ];
		installPhase = ''
			mkdir -p $out/Songs
			ln -s ${src} $out/Songs/TrotMania\ Chrystalize
		'';
	};

	course = stdenv.mkDerivation {
		name = "chrystalize-course";
		phases = "installPhase";
		installPhase = ''
			mkdir -p $out/Courses
			ln -s ${course_full}/Courses/Chrystalize $out/Courses/Chrystalize
		'';
	};

	data = buildEnv {
		name = "chrystalize-data";
		paths = [ music course ];
	};
in
	buildEnv {
		name = "chrystalize-patched";
		paths = [ qol_chrystalize data ];
		ignoreCollisions = true;
	}
