{ pkgs, lib }:

pkgs.stdenvNoCC.mkDerivation rec {
  pname = "proton-ge-custom";
  version = "GE-Proton9-27";

  src = pkgs.fetchurl {
    url = "https://github.com/GloriousEggroll/proton-ge-custom/releases/download/${version}/${version}.tar.gz";
    hash = "sha256-u9MQi6jc8XPdKmDvTrG40H4Ps8mhBhtbkxDFNVwVGTc=";
  };

  nativeBuildInputs = with pkgs; [ makeWrapper ];
  dontConfigure = true;
  dontBuild = true;

  buildCommand = # sh
    ''
      runHook preBuild

      mkdir -p $out/bin/proton-ge
      tar -C $out/bin/proton-ge --strip=1 -x -f $src
      chmod -R u+w $out/bin/proton-ge

      makeWrapper $out/bin/proton-ge/proton $out/bin/proton \
        --prefix PATH : ${lib.makeBinPath [ pkgs.python312 ]}

      runHook postBuild
    '';
}
