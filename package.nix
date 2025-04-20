{
  pkgs,
  lib,
  proton_prefix ? "/mnt/SSD/SteamUnified",
}:

let
  proton-ge = pkgs.callPackage ./proton-ge.nix { };
  proton_dir = proton-ge + "/bin";
in

pkgs.stdenvNoCC.mkDerivation {
  pname = "protonWrapper";
  version = "unstable";

  src = ./.;

  nativeBuildInputs = with pkgs; [
    makeWrapper
    autoPatchelfHook
  ];
  buildInputs = with pkgs; [
    wayland
    bash
    wine
    dxvk
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

  meta = with lib; {
    description = "Game runner with FSR support for Proton/Wine and native Linux games";
    homepage = "https://github.com/mctrxnv/protonWrapper";
    license = licenses.mit;
    platforms = platforms.linux;
    maintainers = [
      {
        email = "xfalwa@gmail.com";
        github = "mctrxnv";
        githubId = 31189199;
        name = "Azikx";
      }
    ];
    mainProgram = "pgr";
  };
}
