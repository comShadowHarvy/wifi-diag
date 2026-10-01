#!/usr/bin/env bash
# wifi-diag.sh - Lightweight POSIX/Bash Wi-Fi Diagnostic Script
# Usage: ./wifi-diag.sh [interface]

set -euo pipefail

# ANSI Colors
BOLD="\033[1m"
CYAN="\033[36m"
GREEN="\033[32m"
YELLOW="\033[33m"
RED="\033[31m"
DIM="\033[2m"
RESET="\033[0m"

# Auto-detect wireless interface if not provided
IFACE="${1:-}"
if [ -z "$IFACE" ]; then
    for dev in /sys/class/net/*; do
        if [ -d "$dev/wireless" ] || [ -d "$dev/phy80211" ]; then
            dev_name="$(basename "$dev")"
            if [ -f "$dev/operstate" ] && [ "$(cat "$dev/operstate")" = "up" ]; then
                IFACE="$dev_name"
                break
            fi
            [ -z "$IFACE" ] && IFACE="$dev_name"
        fi
    done
fi

if [ -z "$IFACE" ]; then
    echo "Error: No wireless interface detected." >&2
    exit 1
fi

echo -e "${BOLD}${CYAN}=== Wi-Fi Diagnostic Info (${IFACE}) ===${RESET}"

# Check connection status
LINK_INFO="$(iw dev "$IFACE" link 2>/dev/null || true)"
if ! echo "$LINK_INFO" | grep -q "Connected to"; then
    echo -e "${YELLOW}Status:${RESET} ${RED}Disconnected${RESET}"
    exit 0
fi

# Extract iw metrics
SSID="$(echo "$LINK_INFO" | awk -F'SSID: ' '/SSID:/ {print $2}')"
BSSID="$(echo "$LINK_INFO" | awk '/Connected to/ {print $3}')"
FREQ="$(echo "$LINK_INFO" | awk '/freq:/ {print $2}')"
SIGNAL="$(echo "$LINK_INFO" | awk -F'signal: ' '/signal:/ {print $2}')"
RX_RATE="$(echo "$LINK_INFO" | awk -F'rx bitrate: ' '/rx bitrate:/ {print $2}')"
TX_RATE="$(echo "$LINK_INFO" | awk -F'tx bitrate: ' '/tx bitrate:/ {print $2}')"

# Station dump details
STATION_INFO="$(iw dev "$IFACE" station dump 2>/dev/null || true)"
SIG_AVG="$(echo "$STATION_INFO" | awk -F'signal avg:[ \t]*' '/signal avg:/ {print $2}')"
EXPECTED_TP="$(echo "$STATION_INFO" | awk -F'expected throughput:[ \t]*' '/expected throughput:/ {print $2}')"
CONN_TIME="$(echo "$STATION_INFO" | awk -F'connected time:[ \t]*' '/connected time:/ {print $2}')"

# Band & Channel
BAND="Unknown"
CHAN="Unknown"
if [ -n "$FREQ" ]; then
    FREQ_INT="${FREQ%.*}"
    if [ "$FREQ_INT" -ge 2412 ] && [ "$FREQ_INT" -le 2484 ]; then
        BAND="2.4 GHz"
        if [ "$FREQ_INT" -eq 2484 ]; then
            CHAN=14
        else
            CHAN=$(( (FREQ_INT - 2412) / 5 + 1 ))
        fi
    elif [ "$FREQ_INT" -ge 5160 ] && [ "$FREQ_INT" -le 5885 ]; then
        BAND="5 GHz"
        CHAN=$(( (FREQ_INT - 5000) / 5 ))
    elif [ "$FREQ_INT" -ge 5955 ] && [ "$FREQ_INT" -le 7115 ]; then
        BAND="6 GHz"
        CHAN=$(( (FREQ_INT - 5950) / 5 ))
    fi
fi

# Wi-Fi standard detection
STANDARD="802.11 Legacy"
if echo "$RX_RATE $TX_RATE" | grep -qi "EHT"; then
    STANDARD="Wi-Fi 7 (802.11be)"
elif echo "$RX_RATE $TX_RATE" | grep -qi "HE"; then
    STANDARD="Wi-Fi 6 (802.11ax)"
elif echo "$RX_RATE $TX_RATE" | grep -qi "VHT"; then
    STANDARD="Wi-Fi 5 (802.11ac)"
elif echo "$RX_RATE $TX_RATE" | grep -qi "HT"; then
    STANDARD="Wi-Fi 4 (802.11n)"
fi

# IP and Gateway
IPV4="$(ip -4 addr show "$IFACE" 2>/dev/null | awk '/inet / {print $2}' | head -n1)"
GATEWAY="$(ip route show default dev "$IFACE" 2>/dev/null | awk '/default via/ {print $3}' | head -n1)"

# Ping latency to gateway
GW_PING="N/A"
if [ -n "$GATEWAY" ]; then
    PING_OUT="$(ping -c 1 -W 1 "$GATEWAY" 2>/dev/null || true)"
    PING_MS="$(echo "$PING_OUT" | awk -F'/' '/rtt min\/avg\/max/ {print $5}')"
    if [ -n "$PING_MS" ]; then
        GW_PING="${PING_MS} ms"
    fi
fi

# Output
echo -e "  ${BOLD}Network:${RESET}"
echo -e "    SSID         : ${BOLD}${SSID}${RESET}"
echo -e "    BSSID        : ${BSSID}"
echo -e "    Standard     : ${GREEN}${STANDARD}${RESET}"
echo ""
echo -e "  ${BOLD}Radio & Frequency:${RESET}"
echo -e "    Band         : ${BAND} (Channel ${CHAN})"
echo -e "    Frequency    : ${FREQ} MHz"
echo ""
echo -e "  ${BOLD}Signal Strength:${RESET}"
echo -e "    Signal       : ${BOLD}${SIGNAL}${RESET} ${SIG_AVG:+(Avg: $SIG_AVG)}"
echo ""
echo -e "  ${BOLD}Speed & Throughput:${RESET}"
echo -e "    RX Bitrate   : ${GREEN}${RX_RATE}${RESET}"
echo -e "    TX Bitrate   : ${CYAN}${TX_RATE}${RESET}"
[ -n "$EXPECTED_TP" ] && echo -e "    Est. Speed   : ${EXPECTED_TP}"
echo ""
echo -e "  ${BOLD}IP & Routing:${RESET}"
echo -e "    IPv4 Address : ${IPV4:-None}"
echo -e "    Gateway      : ${GATEWAY:-None} ${GW_PING:+(Latency: $GW_PING)}"
[ -n "$CONN_TIME" ] && echo -e "    Uptime       : ${CONN_TIME}"
echo -e "${BOLD}${CYAN}========================================${RESET}"
