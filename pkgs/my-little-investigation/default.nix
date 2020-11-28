{ fetchFromGitHub, stdenv, stdenvNoCC, aria2, p7zip, fetchurl, makeDesktopItem,
	SDL2, SDL2_ttf, SDL2_image, SDL2_mixer, curl, cryptopp, libav, tinyxml2 }:

let

	magnet = ''magnet:?xt=urn:btih:533RAFSGEFTQK7OUM5FZKHIPAEZUFZFI&dn=MyLittleInvestigationsInstaller1.1.0.exe&tr=udp%3a%2f%2ftracker.openbittorrent.com%3a80%2fannounce&tr=http%3a%2f%2fexplodie.org%3a6969%2fannounce&tr=http%3a%2f%2fmgtracker.org%3a2710%2fannounce&tr=http%3a%2f%2ftracker.tfile.me%2fannounce&tr=http%3a%2f%2ftracker.torrenty.org%3a6969%2fannounce&tr=http%3a%2f%2ftracker.trackerfix.com%2fannounce&tr=http%3a%2f%2fwww.mvgroup.org%3a2710%2fannounce&tr=udp%3a%2f%2f9.rarbg.com%3a2710%2fannounce&tr=udp%3a%2f%2f9.rarbg.me%3a2710%2fannounce&tr=udp%3a%2f%2f9.rarbg.to%3a2710%2fannounce&tr=udp%3a%2f%2fcoppersurfer.tk%3a6969%2fannounce&tr=udp%3a%2f%2fexodus.desync.com%3a6969%2fannounce&tr=udp%3a%2f%2fglotorrents.pw%3a6969%2fannounce&tr=udp%3a%2f%2fopen.demonii.com%3a1337%2fannounce&tr=udp%3a%2f%2ftracker.coppersurfer.tk%3a6969%2fannounce&tr=udp%3a%2f%2ftracker.glotorrents.com%3a6969%2fannounce&tr=udp%3a%2f%2ftracker.leechers-paradise.org%3a6969%2fannounce&tr=udp%3a%2f%2ftracker.opentrackr.org%3a1337%2fannounce&tr=udp%3a%2f%2ftracker.publicbt.com%3a80%2fannounce&tr=udp%3a%2f%2ftracker4.piratux.com%3a6969%2fannounce'';

	data_source = stdenvNoCC.mkDerivation {
		name = "my-little-investigations-installer.exe";

		nativeBuildInputs = [ aria2 ];

		phases = [ "buildPhase" "installPhase" ];

		buildPhase = "aria2c --check-certificate=false --seed-time=0 \"${magnet}\"";

		installPhase = ''
			cp ./MyLittleInvestigationsInstaller1.1.0.exe $out
		'';

		outputHashMode = "recursive";
		outputHash = "WCkwOi2fayohadc2LTUj2vV+xihWo9O2V77+QWkNKWI=";
		outputHashAlgo = "sha256";
	};

	data_extracted = stdenvNoCC.mkDerivation {
		name = "my-little-investagation-data-unpacked";

		nativeBuildInputs = [ p7zip ];

		unpackPhase = ''
			7z x ${data_source}
		'';

		installPhase = ''
			mkdir $out
			cp -r \$APPDATA/My\ Little\ Investigations/* $out
		'';
	};

	game_source = fetchFromGitHub {
		owner = "GabuEx";
		repo = "my-little-investigations";
		rev = "0689f2ca3e808ba39864f024280abd2e77f8ad20";
		sha256 = "4fsrtAxdS+mfxIHJOlVxt8XcAl2pZHt1Lal2eBnyOMw=";
	};

	desktop_file = makeDesktopItem {
		name = "my-little-investigation";
		exec = "mli";
		icon = "my-little-investigation";
		desktopName = "My Little Investigation";
		categories = "Game";
	};

	game_binary = stdenv.mkDerivation {
		pname = "my-little-investigations";
		version = "git";
		src = game_source;

		patches = [
			(fetchurl {
				url = "https://github.com/GabuEx/my-little-investigations/pull/44.patch";
				sha256 = "bf6rBr6593ERFKD/D47YgIVF2k+AqCVeOu9oGKWibXA=";
			})
		];

		postPatch = ''
			substituteInPlace src/FileFunctions.cpp \
				--replace /usr/share/MyLittleInvestigations ${data_extracted} \
				--replace "localizedCommonResourcesFilePaths)" '"${data_extracted}/Languages/")'
			cp ${./Makefile} Makefile
		'';

		installPhase = ''
			mkdir -p $out/bin
			cp bin/mli $out/bin
			cp -r ${desktop_file}/share $out
		'';

		enableParallelBuilding = true;

		CXXFLAGS = "-I${SDL2.dev}/include/SDL2";

		buildInputs = [
			SDL2
			SDL2_ttf
			SDL2_image
			SDL2_mixer
			curl
			cryptopp
			libav
			tinyxml2
		];
	};
in game_binary
