{ lib, stdenv }:

stdenv.mkDerivation {
  name = "wez-tmux";

  src = ./.;

  dontBuild = true;

  installPhase = ''
    cp -r plugin $out;
  '';
}
