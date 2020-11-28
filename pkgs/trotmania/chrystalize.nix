{ fetchzip, stdenv }:
let
	src = fetchzip {
		url = "https://www.mylittlekaraoke.com/trotmania/V/TrotMania%20Chrystalize-003.zip";
		sha256 = "gE0Hw41ZSDzo99EPEwQgioMQONcyXFtK6I1LHWbKsog=";
	};
in stdenv.mkDerivation {
	name = "chrystalize-data";
	phases = [ "installPhase" ];
	installPhase = ''
		mkdir -p $out/Songs
		ln -s ${src} $out/Songs/TrotMania\ Chrystalize
	'';
}
