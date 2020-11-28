{ fetchurl, stdenv, fetchmega, unzip, buildEnv, fetchzip }:
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

	theme_src = fetchmega {
		url = "https://mega.nz/file/bhoklD7b#Sh6cQplXOjzTmmg7H0nIgc8T2ZjXfFLZIrhnk4_6XpM";
		sha256 = "0kpuwiS/2HCO418NT3JVSZnw1OWpc2bWuo0qvtk+40E=";
	};

	theme = stdenv.mkDerivation {
		name = "euphorius-theme";
		src = "${theme_src}/*.zip";
		nativeBuildInputs = [ unzip ];
		installPhase = ''
			rm README.txt
			mkdir -p $out
			cp -r * $out
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

in buildEnv {
	name = "euphorius-data";
	paths = [ music theme mod_lab trials ];
}
