{ cacert, curl, gnutar, stdenv }:

{
	url,
	name ? "${baseNameOf (toString (url))}-unpacked",
	sha256,
}: stdenv.mkDerivation {
	inherit url name;
	nativeBuildInputs = [ curl gnutar ];
	phases = [ "buildPhase" "installPhase" ];
	buildPhase = ''
		file=$(basename $url)
		curl -o $file -L $url
	'';
	installPhase =''
		case $file in
			*.mlk)
				mkdir -p $out/songs
				tar -xf "$file" -C $out/songs
				;;
			*.mlt)
				mkdir -p $out/themes
				tar -xf "$file" -C $out/themes
				;;
			*.mlu)
				mkdir -p $out
				tar -xf "$file" -C $out
				;;
			*)
				echo "unknown file extension for $file"
				exit -1
				;;
		esac
	'';

	SSL_CERT_FILE = "${cacert}/etc/ssl/certs/ca-bundle.crt";

	outputHashMode = "recursive";
	outputHash = sha256;
	outputHashAlgo = "sha256";
}
