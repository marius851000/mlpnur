{ megatools, curl, stdenvNoCC, cacert }:

{
	url,
	sha256
}:

let
	#megacmd_faster = megacmd.overrideAttrs (_: {enableParallelBuilding = true;});
in
stdenvNoCC.mkDerivation {
	name = "downloaded-from-mega";

	phases = [ "buildPhase" "installPhase" ];

	nativeBuildInputs = [ megatools curl ];

	SSL_CERT_FILE = "${cacert}/etc/ssl/certs/ca-bundle.crt";
	NIX_SSL_CERT_FILE = "${cacert}/etc/ssl/certs/ca-bundle.crt";
	
	buildPhase = ''
		echo downloading ${url}
		mkdir home
		export HOME=$PWD/home
		mkdir downloaded
		cd downloaded
		megadl "${url}" .
	'';

	installPhase = ''
		cp -r . $out
	'';

	outputHashMode = "recursive";
	outputHash = sha256;
	outputHashAlgo = "sha256";
}
