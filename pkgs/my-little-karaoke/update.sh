nix-shell -p python3 -p python3Packages.beautifulsoup4 -p python3Packages.requests \
	-p python3Packages.unidecode --command "python3 fetch_beta_release.py"
