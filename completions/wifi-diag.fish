# Fish completion for wifi-diag and wifi-info

complete -c wifi-diag -s i -l interface -d "Specify wireless interface" -a "(ls /sys/class/net 2>/dev/null)"
complete -c wifi-diag -s w -l watch -d "Continuously monitor Wi-Fi status with sparklines"
complete -c wifi-diag -s c -l channels -l advisor -d "Display channel congestion analysis & advisor"
complete -c wifi-diag -s m -l mesh -l roam -d "Display mesh / multi-AP nodes for current SSID"
complete -c wifi-diag -s t -l test -l ping-test -d "Run jitter, packet loss, and bufferbloat stress test"
complete -c wifi-diag -l log -l survey -d "Log diagnostic records to CSV file" -r
complete -c wifi-diag -s s -l scan -d "Scan and list nearby Wi-Fi access points"
complete -c wifi-diag -s j -l json -d "Output full diagnostics in JSON format"
complete -c wifi-diag -s 1 -l one-line -d "Output concise one-line status string"
complete -c wifi-diag -l no-ping -d "Skip gateway and internet ping latency checks"
complete -c wifi-diag -l no-color -d "Disable ANSI color codes"
complete -c wifi-diag -s v -l version -d "Show version"
complete -c wifi-diag -s h -l help -d "Show help"

# Also bind to wifi-info
complete -c wifi-info -w wifi-diag
