{ ultrastardx, fetchurl, stdenv, writeScript, bash, konsole, makeDesktopItem,
	callPackage, buildEnv, beta ? false }:

let
	desktop_file = makeDesktopItem {
		name = "my-little-karaoke";
		exec = "my-little-karaoke" + (if beta then "-beta" else "");
		icon = "my-little-karaoke";
		desktopName = "My Little Karaoke" + (if beta then " (beta)" else "");
		categories = "Game";
	};

	data = callPackage ./data.nix { inherit beta; };

	mlk = ultrastardx.overrideAttrs (oldAttrs: {
		name = "my-little-karaoke";

		prePatch = (oldAttrs.prePatch or "") + ''
			substituteInPlace src/base/UIni.pas \
				--replace \'Modern\' \'MyLittleKaraoke\'
		'';

		postInstall = (oldAttrs.postInstall or "") + ''
			rm -r $out/share/ultrastardx/avatars
			ln -s ${data}/avatars $out/share/ultrastardx/avatars
			ln -s ${data}/songs $out/share/ultrastardx/songs
			#rm -r $out/share/ultrastardx/themes/
			cp -rf ${data}/themes/* $out/share/ultrastardx/themes
			mv $out/bin/ultrastardx $out/bin/my-little-karaoke${if beta then "-beta" else ""}
			cp -r ${desktop_file}/share $out
		'';

		dontStrip = true;
	});
in mlk
