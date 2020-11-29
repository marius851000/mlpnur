{ ultrastardx, fetchurl, stdenv, writeScript, bash, konsole, makeDesktopItem,
	callPackage, buildEnv }:

let
	desktop_file = makeDesktopItem {
		name = "my-little-karaoke";
		exec = "my-little-karaoke";
		icon = "my-little-karaoke";
		desktopName = "My Little Karaoke";
		categories = "Game";
	};

	data = callPackage ./data.nix { };

	mlk = ultrastardx.overrideAttrs (oldAttrs: {
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
			chmod +w $out/share/ultrastardx/themes/MyLittleKaraoke.ini
			cat ${./patch_theme.ini} >> $out/share/ultrastardx/themes/MyLittleKaraoke.ini
			cp $out/bin/ultrastardx $out/bin/my-little-karaoke
		'';

		dontStrip = true;
	});
in mlk
