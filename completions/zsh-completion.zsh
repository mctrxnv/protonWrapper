#compdef proton-game-runner run-with-proton

_proton-game-runner() {
    local state

    _arguments \
        '1: :->game' \
        '(- *)'{-h,--help}'[Show help]' \
        '--hud[Enable DXVK HUD]' \
        '--prefix[Set prefix path]:directory:_files -/' \
        '--proton[Set Proton path]:directory:_path_files -/ ~/.steam/steam/compatibilitytools.d/GE-Proton*(/)'
        '--steam[Set Steam path]:directory:_files -/' \
        '--opengl[Use OpenGL]' \
        '--wine[Use Wine]' \
        '--fsr[Enable FSR]' \
        '--fsr-level[FSR quality level]:level:(0 1 2 3 4 5)' \
        '--fsr-sharpening[FSR sharpening (0-5)]:sharpening:(0 1 2 3 4 5)' \
        '--no-fixes[Disable ProtonFixes]' \
        '--debug-fixes[Enable debug output]:debug level:(0 1 2)' \
        '*:game:_files'
}

_proton-game-runner "$@"
