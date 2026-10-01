#compdef wifi-diag wifi-info

_wifi_diag() {
    local -a arguments

    arguments=(
        '(-i --interface)'{-i,--interface}'[Specify wireless interface]:interface:_net_interfaces'
        '(-w --watch)'{-w,--watch}'[Continuously monitor Wi-Fi status with sparklines]:interval:(0.5 1.0 2.0 5.0)'
        '(-c --channels --advisor)'{-c,--channels,--advisor}'[Display channel congestion analysis & advisor]'
        '(-m --mesh --roam)'{-m,--mesh,--roam}'[Display mesh / multi-AP nodes for current SSID]'
        '(-t --test --ping-test)'{-t,--test,--ping-test}'[Run jitter, packet loss, and bufferbloat stress test]'
        '(--log --survey)'{--log,--survey}'[Log diagnostic records to CSV file]:csv file:_files -g "*.csv"'
        '(-s --scan)'{-s,--scan}'[Scan and list nearby Wi-Fi access points]'
        '(-j --json)'{-j,--json}'[Output full diagnostics in JSON format]'
        '(-1 --one-line)'{-1,--one-line}'[Output concise one-line status string]'
        '--no-ping[Skip gateway and internet ping latency checks]'
        '--no-color[Disable ANSI color codes]'
        '(-v --version)'{-v,--version}'[Show version]'
        '(-h --help)'{-h,--help}'[Show help]'
    )

    _arguments -s $arguments
}

_wifi_diag "$@"
