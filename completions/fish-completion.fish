complete -c proton-game-runner -n __fish_use_subcommand -s h -l help -d 'Show help'
complete -c proton-game-runner -n __fish_use_subcommand -l hud -d 'Enable DXVK HUD'
complete -c proton-game-runner -n __fish_use_subcommand -l prefix -d 'Set prefix path' -r -F
complete -c proton-game-runner -n __fish_use_subcommand -l proton -d 'Set Proton path' -xa "(ls -d ~/.steam/steam/compatibilitytools.d/GE-Proton* 2>/dev/null | sort -Vr)"
complete -c proton-game-runner -n __fish_use_subcommand -l steam -d 'Set Steam path' -r -F
complete -c proton-game-runner -n __fish_use_subcommand -l opengl -d 'Use OpenGL'
complete -c proton-game-runner -n __fish_use_subcommand -l wine -d 'Use Wine'
complete -c proton-game-runner -n __fish_use_subcommand -l fsr -d 'Enable FSR'
complete -c proton-game-runner -n __fish_use_subcommand -l fsr-level -d 'FSR quality level' -x -a "0 1 2 3 4 5"
complete -c proton-game-runner -n __fish_use_subcommand -l fsr-sharpening -d 'FSR sharpening' -x -a "0 1 2 3 4 5"
complete -c proton-game-runner -n __fish_use_subcommand -l no-fixes -d 'Disable ProtonFixes'
complete -c proton-game-runner -n __fish_use_subcommand -l debug-fixes -d 'Enable debug output' -x -a "0 1 2"
complete -c proton-game-runner -n '__fish_seen_subcommand_from proton-game-runner' -a '(__fish_complete_path)'

complete -c run-with-proton -n __fish_use_subcommand -s h -l help -d 'Show help'
complete -c run-with-proton -n __fish_use_subcommand -l hud -d 'Enable DXVK HUD'
complete -c run-with-proton -n __fish_use_subcommand -l prefix -d 'Set prefix path' -r -F
complete -c run-with-proton -n __fish_use_subcommand -l proton -d 'Set Proton path' -r -F
complete -c run-with-proton -n __fish_use_subcommand -l steam -d 'Set Steam path' -r -F
complete -c run-with-proton -n __fish_use_subcommand -l opengl -d 'Use OpenGL'
complete -c run-with-proton -n __fish_use_subcommand -l wine -d 'Use Wine'
complete -c run-with-proton -n __fish_use
