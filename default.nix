{ nixpkgs ? import <nixpkgs> {}}:

{
	my-little-investigation = nixpkgs.callPackage ./pkgs/my-little-investigation {};
}
