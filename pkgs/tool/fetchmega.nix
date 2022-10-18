{ megatools, curl, stdenvNoCC, cacert }:

{
	url,
	sha256,
	installPhase ? null,
	name ? "downloaded-from-mega",
	nativeBuildInputs ? []
}:

let
	#megacmd_faster = megacmd.overrideAttrs (_: {enableParallelBuilding = true;});
in
stdenvNoCC.mkDerivation {
	inherit name;

	phases = [ "buildPhase" "installPhase" ];

	nativeBuildInputs = [ megatools curl ] ++ nativeBuildInputs;

	SSL_CERT_FILE = "${cacert}/etc/ssl/certs/ca-bundle.crt";
	NIX_SSL_CERT_FILE = "${cacert}/etc/ssl/certs/ca-bundle.crt";
	
	buildPhase = ''
		echo downloading ${url}
		mkdir home
		export HOME=$PWD/home
		mkdir downloaded
		cd downloaded
		megadl "${url}"
	'';

	installPhase = if (installPhase != null) then installPhase else
	''
		cp -r . $out
	'';

	outputHashMode = "recursive";
	outputHash = sha256;
	outputHashAlgo = "sha256";
}
