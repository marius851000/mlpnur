{ fetchzip, fetchmega, stdenv, unzip, buildEnv, qol_full, course_full }:
let
	src = fetchzip {
		url = "https://www.mylittlekaraoke.com/trotmania/V/TrotMania%20III.zip";
		sha256 = "56oTcXCn7pl77SAd6rVJ3Qtidn2/Yz7dkz5ywKdO/6Q=";
	};

	theme_src = fetchmega {
		url = "https://mega.nz/file/z45BkQBD#uC6BVs2aGRHoTrnxlOJ_lMixQ3hekHALeNeiZ7BybS4";
		sha256 = "f50EBjwUnhvNSwFIq/msCtR723R6w5F3iFnTZt1eV7E=";
	};

	theme = stdenv.mkDerivation {
		name = "aeternum-obscurum-themes";
		nativeBuildInputs = [ unzip ];
		src = "${theme_src}/*.zip";
		installPhase = ''
			mkdir -p $out/Themes
			cp -r * $out/Themes
		'';
	};

	music = stdenv.mkDerivation {
		name = "aeternum-obscurum-music";
		phases = [ "installPhase" ];
		installPhase = ''
			mkdir -p $out/Songs
			ln -s ${src} $out/Songs/TrotMania\ III
		'';
	};

	qol = stdenv.mkDerivation {
		name = "aeternum-obscurum-qol";
		phases = "installPhase";
		installPhase = ''
			mkdir -p $out/Songs
			ln -s ${qol_full}/Songs/TrotMania\ III $out/Songs/TrotMania\ III
		'';
	};

	course = stdenv.mkDerivation {
		name = "aeternum-obscurum-course";
		phases = "installPhase";
		installPhase = ''
			mkdir -p $out/Courses
			ln -s ${course_full}/Courses/Aeturnum\ Obscurum $out/Courses/Aeturnum\ Obscurum
		'';
	};

	data = buildEnv {
		name = "aeternum-obscurum-data";
		paths = [ music theme course];
	};
in buildEnv {
	name = "aeternum-obscurum-patched";
	paths = [ qol data ];
	ignoreCollisions = true;
}
