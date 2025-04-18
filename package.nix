{
  pkgs,
  lib,
  proton_prefix ? "/mnt/SSD/SteamUnified",
}:

let
  proton-ge = pkgs.callPackage ./proton-ge.nix { };
  proton_dir = "${proton-ge}/share/proton-ge";
in

pkgs.stdenvNoCC.mkDerivation {
  pname = "proton-game-runner";
  version = "1.2";

  src = ./.;

  nativeBuildInputs = with pkgs; [
    makeWrapper
    autoPatchelfHook
  ];
  buildInputs = with pkgs; [
    bash
    wine
    dxvk
    winetricks
  ];

  dontBuild = true;
  dontAutoPatchelf = true;

  installPhase = ''
    mkdir -p $out/bin \
      $out/share/bash-completion/completions \
      $out/share/zsh/site-functions \
      $out/share/fish/vendor_completions.d

    # Install main script
    install -Dm755 protonWrapper  $out/bin/pgr
    chmod   +x                    $out/bin/pgr

    # Create wrapper with all dependencies
    wrapProgram $out/bin/pgr \
      --prefix PATH : ${
        with pkgs;
        lib.makeBinPath [
          wine
          dxvk
          winetricks
          steam-run
        ]
      } \
      --set         DXVK_PATH         ${pkgs.dxvk} \
      --set         WINETRICKS_PATH   ${pkgs.winetricks} \
      --set-default PROTON_DIR       "${proton_dir}" \
      --set-default PROTON_PREFIX    "${proton_prefix}"

    # Generate and install completions with FSR support
    echo "Generating shell completions..."
    cp completions/bash-completion.bash  $out/share/bash-completion/completions/proton-game-runner
    cp completions/zsh-completion.zsh    $out/share/zsh/site-functions/_proton-game-runner
    cp completions/fish-completion.fish  $out/share/fish/vendor_completions.d/proton-game-runner.fish

    substituteInPlace completions/bash-completion.bash \
      --replace 'GE-Proton*' 'GE-Proton* | sort -Vr'
    substituteInPlace completions/fish-completion.fish \
      --replace 'GE-Proton*' 'GE-Proton* | sort -Vr'
  '';

  postFixup = ''
    # Add desktop file with FSR options in comment
    mkdir -p $out/share/applications
    cat > $out/share/applications/proton-game-runner.desktop << EOF
    [Desktop Entry]
    Name=Proton Game Runner
    Comment=Run games with FSR support (--fsr --fsr-level N --fsr-sharpening N)
    Exec=run-with-proton %f
    Icon=wine
    Terminal=true
    Type=Application
    Categories=Game;Emulator;
    MimeType=application/x-ms-dos-executable;application/x-executable;
    EOF
  '';

  meta = with lib; {
    description = "Game runner with FSR support for Proton/Wine and native Linux games";
    homepage = "https://github.com/mctrxnv/protonWrapper";
    license = licenses.mit;
    platforms = platforms.linux;
  };
}
