{ stdenv, fetchzip, openjdk, lib, libXxf86vm, bash, steam-run }:

stdenv.mkDerivation rec {
	pname = "patapony";
	version = "1.01";

	src = fetchzip {
		url = "http://www.oddwarg.com/Permanent/PataPony.zip";
		sha256 = "I0SLFVTbqi4CWjjXpc0r8ftNvQlHBL1xd5/aSqRnSzw=";
	};

	phases = "installPhase";

	patapony_out = "$out/share/patapony";

	installPhase = ''
		mkdir -p $out/share
		cp -rf $src/PataPony ${patapony_out}
		chmod +w ${patapony_out}
		rm ${patapony_out}/settings.dat
		mkdir -p $out/bin
		echo "#!${bash}/bin/bash
			mkdir -p ~/.local/share/patapony
			pushd ~/.local/share/patapony
			export LD_LIBRARY_PATH=${lib.makeLibraryPath [ libXxf86vm ]}
			chmod -R +w .
			ln -sf ${patapony_out}/* .
			rm -f binary.jar
			cp -f ${patapony_out}/binary.jar .
			#for some reason, wrapping it in steam-run make it work
			${steam-run}/bin/steam-run ${openjdk}/bin/java -Xms256M -Xmx512M -jar ./binary.jar
			popd
		" > $out/bin/patapony
		chmod +x $out/bin/patapony
	'';
}
