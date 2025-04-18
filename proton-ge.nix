{ pkgs, lib }:

pkgs.stdenv.mkDerivation rec {
  pname = "proton-ge";
  version = "GE-Proton9-27";

  src = pkgs.fetchurl {
    url = "https://github.com/GloriousEggroll/proton-ge-custom/releases/download/${version}/${version}.tar.gz";
    hash = "sha256-u9MQi6jc8XPdKmDvTrG40H4Ps8mhBhtbkxDFNVwVGTc=";
  };

  nativeBuildInputs = with pkgs; [
    makeWrapper
    autoPatchelfHook
  ];

  buildCommand = # sh
    ''
      runHook preBuild

      mkdir -p $out/share/proton-ge
      tar -C $out/share/proton-ge --strip=1 -x -f $src
      wrapProgram $out/share/proton-ge/proton \
        --prefix PATH ':' \
          "${lib.makeBinPath (with pkgs; [ python312 ])}"

      runHook postBuild
    '';

  passthru.updateScript = pkgs.nix-update-script { };

  meta = with lib; {
    description = "Compatibility tool for Steam Play based on Wine and additional components";
    homepage = "https://github.com/GloriousEggroll/proton-ge-custom";
    license = licenses.bsd3;
    platforms = [ "x86_64-linux" ];
    preferLocalBuild = true;
  };
}
