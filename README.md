# wifi-diag 📡

A comprehensive, zero-dependency Wi-Fi diagnostic and status tool for Linux.

It provides detailed and accurate metrics on your active wireless connection, including **SSID, Frequency, Band, Channel Width, Signal Strength (dBm & meter), RX/TX Bitrates (with MCS & MIMO streams), Estimated Throughput, Security, Hardware Driver, IP Routing, and Gateway/Internet Latency**.

---

## ✨ Features

- **📶 Wireless Connection Info**: Network SSID, BSSID (AP MAC), Security (WPA2/WPA3 Personal/Enterprise), Wi-Fi Generation (Wi-Fi 7, Wi-Fi 6, Wi-Fi 5, etc.), and Operating Mode.
- **📻 Radio & Frequencies**: Band (2.4 GHz, 5 GHz, 6 GHz), Channel number, Frequency (MHz), Channel Width (20/40/80/160 MHz), Center Frequency, and TX Power.
- **📊 Signal Quality**: Real-time RSSI in dBm, average dBm, signal percentage (`0-100%`), Unicode signal bars (`▂▄▆█`), qualitative ratings (*Excellent*, *Good*, *Fair*, *Weak*), and colorized visual meter bars `[████████░░]`.
- **⚡ Speed & Bitrates**:
  - **RX Bitrate**: e.g., `1200.9 Mbit/s (HE-MCS 11, 2x2 MIMO, 80MHz)`
  - **TX Bitrate**: e.g., `720.6 Mbit/s (HE-MCS 7, 2x2 MIMO, 80MHz)`
  - **Estimated Throughput**: Real-time link throughput estimation from kernel station metrics.
  - **Max AP Capability**: Maximum rate advertised by the access point.
- **🌐 Network & Latency**: IPv4 CIDR, IPv6 global & link-local addresses, Default Gateway, DNS servers, and fast ICMP latency checks (router RTT + Internet 1.1.1.1 RTT).
- **⏱️ Reliability & Statistics**: Connection uptime, data transferred (RX/TX in human-readable MB/GB and packet counts), and error statistics (TX retries, failed packets, RX drops).
- **🔄 Live Watch Mode (`-w`)**: Real-time refreshing dashboard with live bandwidth rates (↓ KB/s, ↑ KB/s)—perfect for walking around to test coverage.
- **🔍 Network Scanner (`-s`)**: Discovers nearby Wi-Fi networks sorted by signal strength with security, channel, and frequency.
- **💻 Status Bar Ready (`-1`)**: Compact one-line output ideal for Waybar, Polybar, i3blocks, or tmux.
- **📦 JSON Output (`-j`)**: Machine-readable JSON output for scripting and custom automation.
- **🚀 Zero Dependencies**: Runs using standard Python 3 (stdlib only). Includes a lightweight pure-Bash companion script (`wifi-diag.sh`).

---

## 🖥️ Preview

```text
╔══════════════════════════════════════════════════════════════════════════════════╗
║ Wi-Fi Diagnostic & Status  ──  wlan0 (Realtek RTL8852BE PCIe 802.11ax)          ║
╚══════════════════════════════════════════════════════════════════════════════════╝

  ┌── Wireless Connection ─────────────────────────────────────────────────────────┐
  │  SSID            : RCMP_mobile
  │  BSSID           : e8:d3:eb:da:29:07
  │  Security        : WPA2 WPA3
  │  Standard        : Wi-Fi 6 (802.11ax)
  │  Mode            : Managed
  ├── Frequency & Radio ───────────────────────────────────────────────────────────┤
  │  Band            : 5 GHz (Channel 149)
  │  Frequency       : 5745 MHz | Channel Width: 80 MHz
  │  Center Freq     : 5775 MHz | TX Power: 30.00 dBm
  ├── Signal & Link Quality ───────────────────────────────────────────────────────┤
  │  Signal Level    : -45 dBm (Avg: -44 dBm)
  │  Signal Meter    : [████████████████████████] 100% ▂▄▆█ [Excellent]
  ├── Speed & Throughput ──────────────────────────────────────────────────────────┤
  │  RX Bitrate      : 1200.9 Mbit/s (HE-MCS 11, 2x2 MIMO, 80MHz)
  │  TX Bitrate      : 720.6 Mbit/s (HE-MCS 7, 2x2 MIMO, 80MHz)
  │  Est. Throughput : 609.3 Mbps | Max AP Rate: 1170 Mbit/s
  ├── Network & Latency ───────────────────────────────────────────────────────────┤
  │  IPv4 Address    : 192.168.1.164/24
  │  IPv6 Global     : fd8b:88ea:d899:1:174b:c839:c390:5e3a/64
  │  Default Gateway : 192.168.1.1 (9.5 ms)
  │  DNS Server(s)   : 192.168.1.1, fd8b:88ea:d899:1::1
  │  Internet Latency: 24.1 ms (Cloudflare 1.1.1.1)
  ├── Traffic & Reliability ───────────────────────────────────────────────────────┤
  │  Connected Time  : 2m 14s
  │  Data Received   : 45.62 MB (17,217 pkts)
  │  Data Sent       : 17.92 MB (16,803 pkts)
  │  Error Rates     : 0 retries, 0 failed, 121 rx drops
  └────────────────────────────────────────────────────────────────────────────────┘
```

---

## 🚀 Installation

### Option 1: Quick Install (User-level)
```bash
make install
```
This installs `wifi-diag`, `wifi-diag.sh`, and the symlink `wifi-info` into `~/.local/bin/`.

### Option 2: System-wide Install
```bash
sudo make install PREFIX=/usr/local
```

### Option 3: Run directly without installation
```bash
./wifi-diag
# or using the shell script:
./wifi-diag.sh
```

---

## 📖 Usage & Options

```bash
wifi-diag [options]
```

| Option | Description |
|---|---|
| *(none)* | Show the full Wi-Fi status report dashboard |
| `-w, --watch [SEC]` | Real-time continuous monitor (default: 1.0s interval) |
| `-s, --scan` | Scan and display a list of all nearby Wi-Fi networks |
| `-j, --json` | Output all diagnostic data as structured JSON |
| `-1, --one-line` | Compact one-line summary string |
| `-i, --interface IFACE` | Target a specific interface (default: auto-detected) |
| `--no-ping` | Skip ping latency tests for instant output |
| `--no-color` | Disable ANSI terminal color formatting |
| `-v, --version` | Display version information |
| `-h, --help` | Display help and examples |

---

## 💡 Examples

### 1. Full Wi-Fi Status
```bash
wifi-diag
```

### 2. Live Monitoring Mode
Continuously monitors signal strength, bitrate adjustments, and live data transfer rates:
```bash
wifi-diag -w
# or with a 2-second refresh rate:
wifi-diag -w 2
```

### 3. Scan Nearby Networks
```bash
wifi-diag -s
```
Output:
```text
Nearby Wi-Fi Networks (40 found):

USE  SSID                       BSSID               CHAN  FREQ      SIGNAL        RATE          SECURITY
────────────────────────────────────────────────────────────────────────────────────────────────────────
 *  RCMP_mobile                e8:d3:eb:da:29:07   149   5745 MHz  ▂▄▆█  97%     1170 Mbit/s   WPA2 WPA3
    RCMP_mobile                e8:d3:eb:da:29:06   1     2412 MHz  ▂▄▆█  90%     1170 Mbit/s   WPA2 WPA3
    1484333                    40:47:5e:45:dc:83   1     2412 MHz  ▂▄▆█  90%     1170 Mbit/s   WPA3
    HomeNetwork                b8:27:eb:11:3c:7f   6     2437 MHz  ▂▄▆_  65%     270 Mbit/s    WPA2
```

### 4. One-Line Summary (Waybar / Polybar / Tmux)
```bash
wifi-diag -1
```
Output:
```text
RCMP_mobile | 5 GHz Ch149 | -45dBm (100%) | RX:1201M TX:721M | 192.168.1.164 (9.5ms)
```

### 5. JSON Output for Automation
```bash
wifi-diag -j
```
Extract metrics easily with `jq`:
```bash
wifi-diag -j | jq '.signal.level_dbm'
wifi-diag -j | jq '.speed.rx_bitrate_formatted'
```

### 6. Lightweight Bash Version
```bash
./wifi-diag.sh
```

---

## 🔧 Requirements
- Linux OS
- Python 3.6+ (standard library only)
- Wireless network tools: `iw` and `nmcli` (NetworkManager) or `iproute2`
