# Bash completion for wifi-diag and wifi-info

_wifi_diag_complete() {
    local cur prev words cword
    _init_completion || return

    local opts="-i --interface -w --watch -c --channels --advisor -m --mesh --roam -t --test --ping-test --log --survey -s --scan -j --json -1 --one-line --no-ping --no-color -v --version -h --help"

    case "${prev}" in
        -i|--interface)
            local ifaces=$(ls /sys/class/net 2>/dev/null)
            COMPREPLY=( $(compgen -W "${ifaces}" -- "${cur}") )
            return 0
            ;;
        --log|--survey)
            _filedir csv
            return 0
            ;;
        -w|--watch)
            COMPREPLY=( $(compgen -W "0.5 1.0 2.0 5.0" -- "${cur}") )
            return 0
            ;;
    esac

    if [[ "${cur}" == -* ]]; then
        COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
        return 0
    fi
}

complete -F _wifi_diag_complete wifi-diag
complete -F _wifi_diag_complete wifi-info
