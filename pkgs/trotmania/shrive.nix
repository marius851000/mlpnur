{ stdenv, fetchurl, fetchzip, fetchmega, unzip, buildEnv, qol_full, course_full }:

let
	music_src = fetchurl {
		name = "shrive.zip";
		url = "https://www.mylittlekaraoke.com/trotmania/V/TrotMania%20V-004.zip";
		sha256 = "BvmZTNUq+0S/5VL5DaInj4gqwdTqvlCS+apTJiyujmY=";
	};

	music = stdenv.mkDerivation {
		name = "shrive-music";
		nativeBuildInputs = [ unzip ];
		src = music_src;
		installPhase = ''
			mkdir -p $out/Songs/TrotMania\ V/
			mv * $out/Songs/TrotMania\ V/
		'';
	};

	qol = stdenv.mkDerivation {
		name = "shrive-qol";
		phases = "installPhase";
		installPhase = ''
			mkdir -p $out/Songs
			ln -s ${qol_full}/Songs/TrotMania\ V $out/Songs/TrotMania\ V
			ln -s ${qol_full}/Themes $out/Themes
		'';
	};

	theme_src = fetchmega {
		url = "https://mega.nz/#!CwIzXYoa!rPTex2-oFqOoa0iENfgCFfBRat1aJM7zjGr2LiHdrYE";
		sha256 = "0bGJGvp8yq42y/wvJ1N69TRESh1SlV7vDhYuoFD3g+I=";
	};

	theme = stdenv.mkDerivation {
		name = "shrive-theme";
		src = "${theme_src}/*.zip";
		nativeBuildInputs = [ unzip ];
		buildPhase = ''
			rm README.*
			rm -r docs
			chmod +w -R .
			mv Theme Themes
		'';
		installPhase = ''
			mkdir $out
			mv * $out
		'';
	};

	course = stdenv.mkDerivation {
		name = "shrive-course";
		phases = "installPhase";
		installPhase = ''
			mkdir -p $out/Courses
			ln -s ${course_full}/Courses/Shrive $out/Courses/Shrive
		'';
	};
	
	data = buildEnv {
		name = "shrive-data";
		paths = [ music theme course ];
	};
in buildEnv {
		name = "shrive-patched";
		paths = [ qol data ];
		ignoreCollisions = true;
	}
