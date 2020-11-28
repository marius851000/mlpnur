{ fetchmega, unzip, stdenv }:

let
	qol_src = fetchmega {
		url = "https://mega.nz/file/hBlCgY5b#zZ9K4pq-T5uifFLxBNhsmEtzyf3fIFfceJPAxlDr6tU";
		sha256 = "sha256-6ktwFfWI23Eiv+AmuuFAAceGlMIA/HqoK4IQrw2aPm8=";
	};
in
stdenv.mkDerivation {
	name = "trotmania-quality-of-life";
	nativeBuildInputs = [ unzip ];
	src = "${qol_src}/*.zip";
	unpackPhase = ''
		mkdir unpack
		cd unpack
		unzip $src
		chmod +w -R .
	'';
	installPhase = ''
		mkdir -p $out
		mv * $out
	'';
}
