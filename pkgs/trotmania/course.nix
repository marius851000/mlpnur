{ fetchmega, stdenv, unzip }:
let
	course_src = fetchmega {
		url = "https://mega.nz/#!z5IEWISZ!SXS-WP2GeZq0C2hoWvYWdcEeRymzoVD-639r0nMqPWk";
		sha256 = "piDMvlKBLsDswn0xzBh3zfyzdXQ68CKewyMTL5yLPlo=";
	};
in
	stdenv.mkDerivation {
		name = "course_full";
		nativeBuildInputs = [ unzip ];
		src = "${course_src}/*.zip";
		installPhase = ''
			mkdir -p $out/Courses
			chmod +w -R .
			mv * $out/Courses
		'';
	}
