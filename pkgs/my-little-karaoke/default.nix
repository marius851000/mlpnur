{ ultrastardx, fetchurl, stdenv, writeScript, bash, konsole, makeDesktopItem }:

#TODO: understand how downloading work, and add those directly in the package
let
	ultrastardx_folder = "~/.ultrastardx";

	download_script_unpatched = fetchurl {
		name = "downloader.sh";
		url = "http://djazz.se/nas/games/?dl=my-little-karaoke-songs";
		sha256 = "RJCbUEWYqEOklTQuIvlz2+p0MNli7W8UyWg0s+Ou9pc=";
	};

	download_script = stdenv.mkDerivation {
		phases = ["buildPhase" "installPhase"];
		name = "downloader_patched.sh";
		buildPhase = ''
			cp ${download_script_unpatched} downloader.sh
			substituteInPlace downloader.sh \
				--replace "echo \"You can now close this window.\"" ""
		'';
		installPhase = "cp downloader.sh $out";
	};

	updater_script = writeScript "updater.sh" ''#!${bash}/bin/bash
		bash ${download_script} ${ultrastardx_folder}
		echo "download finished"
	'';

	startup_script = writeScript "start_mlk.sh" ''#!${bash}/bin/bash
		if test -f ${ultrastardx_folder}/.nixmlk_downloaded; then
			echo "no download of my little karaoke required"
		else
			echo "downloading the data, opening a graphical terminal"
			${konsole}/bin/konsole -e bash ${updater_script}
			touch ${ultrastardx_folder}/.nixmlk_downloaded
		fi
		${ultrastardx}/bin/ultrastardx
	'';

	desktop_file = makeDesktopItem {
		name = "my-little-karaoke";
		exec = "my-little-karaoke";
		icon = "my-little-karaoke";
		desktopName = "My Little Karaoke";
		categories = "Game";
	};
in
stdenv.mkDerivation {
	name = "my-little-karaoke-downloader";
	phases = "installPhase";
	installPhase = ''
		mkdir -p $out/bin
		ln -s ${updater_script} $out/bin/my-little-karaoke-downloader
		ln -s ${startup_script} $out/bin/my-little-karaoke
		cp -rf ${desktop_file}/share $out
	'';
}
