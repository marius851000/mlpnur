{ fetchurl, stdenv, fetchmega, unzip, buildEnv, fetchzip, qol_full, course_full }:
let
	# I have some issue with fetchzip (due to permission error)
	music_src = fetchurl {
		name = "euphorius-music.zip";
		url = "https://www.mylittlekaraoke.com/trotmania/V/TrotMania%20IV-005.zip";
		sha256 = "0gnAzPTBXcchwffKbl0VKrQ/OctxoEWRp/y0rlD4TWY=";
	};
	music = stdenv.mkDerivation {
		name = "euphorius-music";
		nativeBuildInputs = [ unzip ];
		src = "${music_src}";
		installPhase = ''
			mkdir -p $out/Songs/TrotMania\ IV/
			mv * $out/Songs/TrotMania\ IV
		'';
		outputHashMode = "recursive";
		outputHash = "k6JIlNuetJOFbtvhKpmFVaMLgbaFW8IZ0IIa4DNv18Q=";
		outputHashAlgo = "sha256";
	};

	theme = fetchmega {
		name = "euphorius-theme";
		url = "https://mega.nz/file/bhoklD7b#Sh6cQplXOjzTmmg7H0nIgc8T2ZjXfFLZIrhnk4_6XpM";
		sha256 = "sha256-sDxsDwZSLky/gSe1rkf2UPSaKzLP6KdT8wFbr/8NxiQ=";
		nativeBuildInputs = [ unzip ];
		installPhase = ''
			mkdir out
			cd out
			unzip ../*.zip
			rm */README.txt
			mv * $out
		'';
	};

	mod_lab_src = fetchzip {
		url = "https://www.mylittlekaraoke.com/trotmania/V/TM%20Mod%20Lab.zip";
		sha256 = "5JKU0LTrk7UTxyCdt9kL8tdvEBt46ZDIIRh3FMyvmEw=";
	};

	mod_lab = stdenv.mkDerivation {
		name = "euphorius-mod-lab-music";
		phases = "installPhase";
		installPhase = ''
			mkdir -p $out/Songs
			ln -s ${mod_lab_src} $out/Songs/TM\ Mod\ Lab
		'';
	};

	trials_src = fetchmega {
		url = "https://mega.nz/file/P8JzSIrC#htIUynm1Y1mL0e7FtGwbXmsiqKWB4D8hO24nhWWaTMw";
		sha256 = "/Wah+9Ixwer7DULE2fzw2E4PWXwfhGSo0ExMV5YDyHg=";
	};

	trials = stdenv.mkDerivation {
		name = "trials-of-the-embers";
		nativeBuildInputs = [ unzip ];
		src = "${trials_src}/*.zip";
		installPhase = ''
			rm README.txt
			mkdir -p $out
			mv * $out
		'';
	};

	qol = stdenv.mkDerivation {
		name = "euphorius-qol";
		phases = "installPhase";
		installPhase = ''
			mkdir -p $out/Songs
			ln -s ${qol_full}/Songs/TrotMania\ IV $out/Songs/TrotMania\ IV
		'';
	};

	course = stdenv.mkDerivation {
		name = "euphorius-course";
		phases = "installPhase";
		installPhase = ''
			mkdir -p $out/Courses
			ln -s ${course_full}/Courses/Euphorius $out/Courses/Euphorius
		'';
	};

	data = buildEnv {
		name = "euphorius-data";
		paths = [ music theme mod_lab trials course ];
	};
in buildEnv {
	name = "euphorius-patched";
	paths = [ qol data ];
	ignoreCollisions = true;
}
