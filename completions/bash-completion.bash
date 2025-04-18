_proton_game_runner_complete() {
    local cur prev words cword
    _init_completion || return

    case ${prev} in
        --prefix|--steam)
            _filedir -d
            return
            ;;
        --proton)
            COMPREPLY=($(compgen -W "$(ls -d ~/.steam/steam/compatibilitytools.d/GE-Proton* 2>/dev/null | sort -Vr)" -- "${cur}"))
            return
            ;;
        --fsr-level|--fsr-sharpening)
            COMPREPLY=($(compgen -W '0 1 2 3 4 5' -- "${cur}"))
            return
            ;;
        --hud|--opengl|--wine|--help|--fsr|--no-fixes|--debug-fixes)
            return
            ;;
    esac

    if [[ ${cur} == -* ]]; then
        COMPREPLY=($(compgen -W '--help --hud --prefix --proton --steam --opengl --wine --fsr --fsr-level --fsr-sharpening --no-fixes --debug-fixes' -- "${cur}"))
    else
        _filedir
    fi
}

complete -F _proton_game_runner_complete proton-game-runner
complete -F _proton_game_runner_complete run-with-proton
