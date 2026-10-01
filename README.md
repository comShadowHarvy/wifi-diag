# wifi-diag 📡

A comprehensive, zero-dependency Wi-Fi diagnostic and status suite for Linux.

It delivers real-time metrics on your wireless connection: **SSID, Frequency, Band, Channel, Signal Strength (dBm & visual meter), RX/TX Bitrates (with MCS & MIMO streams), Estimated Throughput, Security, Hardware Driver, IP Routing, Connection Health Score, Channel Congestion Advisor, Mesh Roaming Assistant, and Jitter Testing**.

---

## ✨ Features

- **📶 Wireless Connection Info**: Network SSID, BSSID (AP MAC), Security (WPA2/WPA3 Personal/Enterprise), Wi-Fi Generation (Wi-Fi 7, Wi-Fi 6, Wi-Fi 5, etc.), and Operating Mode.
- **📻 Radio & Frequencies**: Band (2.4 GHz, 5 GHz, 6 GHz), Channel number, Frequency (MHz), Channel Width (20/40/80/160 MHz), Center Frequency, and TX Power.
- **📊 Signal Quality**: Real-time RSSI in dBm, average dBm, signal percentage (`0-100%`), Unicode signal bars (`▂▄▆█`), qualitative ratings (*Excellent*, *Good*, *Fair*, *Weak*), and visual meter bars `[████████░░]`.
- **⚡ Speed & Bitrates**:
  - **RX Bitrate**: e.g. `1200.9 Mbit/s (HE-MCS 11, 2x2 MIMO, 80MHz)`
  - **TX Bitrate**: e.g. `720.6 Mbit/s (HE-MCS 7, 2x2 MIMO, 80MHz)`
  - **Estimated Throughput**: Real-time kernel throughput estimation.
  - **Max AP Rate**: Maximum advertised rate by access point.
- **🩺 Connection Health Score (0–100%)**: Automatically assesses signal quality, gateway latency, packet drops, and channel width, with actionable diagnostic recommendations.
- **🧭 Channel Congestion & Interference Advisor (`-c`)**: Analyzes Wi-Fi congestion across 2.4 GHz, 5 GHz, and 6 GHz spectrums and recommends the cleanest channels.
- **🌐 Mesh & Multi-AP Roaming Assistant (`-m`)**: Discovers all nodes broadcasting your current SSID, compares signal levels, and highlights stronger nodes in range.
- **📈 Live Sparkline Trends in Watch Mode (`-w`)**: Real-time rolling graph of RSSI signal and gateway latency over time, with live transfer rates (↓ KB/s, ↑ KB/s) and roaming event detection.
- **⚡ Jitter & Packet Loss Stress Test (`-t`)**: 10–15 burst ping testing latency variance (mdev), packet loss, and connection stability grading (A+ to F).
- **🚶 Site Survey / Walk-Test CSV Logger (`--log <file.csv>`)**: Continuously records timestamped RF and network data to a CSV file as you map dead zones.
- **💻 Status Bar Ready (`-1`)**: Compact one-line output for Waybar, Polybar, i3blocks, or tmux.
- **📦 JSON Output (`-j`)**: Machine-readable JSON output for scripting and custom automation.
- **🚀 Zero Dependencies**: Runs using standard Python 3 (stdlib only). Includes a lightweight pure-Bash companion script (`wifi-diag.sh`) and shell completions for Bash, Zsh, and Fish.

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
  │  Signal Level    : -49 dBm (Avg: -48 dBm)
  │  Signal Meter    : [████████████████████████] 100% ▂▄▆█ [Excellent]
  ├── Speed & Throughput ──────────────────────────────────────────────────────────┤
  │  RX Bitrate      : 1080.6 Mbit/s (HE-MCS 10, 2x2 MIMO, 80MHz)
  │  TX Bitrate      : 720.6 Mbit/s (HE-MCS 7, 2x2 MIMO, 80MHz)
  │  Est. Throughput : 609.3 Mbps | Max AP Rate: 1170 Mbit/s
  ├── Network & Latency ───────────────────────────────────────────────────────────┤
  │  IPv4 Address    : 192.168.1.164/24
  │  IPv6 Global     : fd8b:88ea:d899:1:174b:c839:c390:5e3a/64
  │  Default Gateway : 192.168.1.1 (6.3 ms)
  │  DNS Server(s)   : 192.168.1.1, fd8b:88ea:d899:1::1
  │  Internet Latency: 24.1 ms (Cloudflare 1.1.1.1)
  ├── Connection Health & Score ───────────────────────────────────────────────────┤
  │  Health Score    : 95/100 [Optimal Connection]
  │  Diagnostic Tips :
  │    • Signal strength is excellent (-49 dBm) with minimal attenuation.
  │    • Gateway latency is acceptable (6.3 ms).
  │    • High-bandwidth 5 GHz connection (80 MHz channel width).
  ├── Traffic & Reliability ───────────────────────────────────────────────────────┤
  │  Connected Time  : 21m 0s
  │  Data Received   : 910.05 MB (288,102 pkts)
  │  Data Sent       : 110.52 MB (167,117 pkts)
  │  Error Rates     : 0 retries, 4 failed, 427 rx drops
  └────────────────────────────────────────────────────────────────────────────────┘
```

---

## 🚀 Installation

### Option 1: User Installation (Recommended)
```bash
make install
```
Installs `wifi-diag`, `wifi-diag.sh`, the symlink `wifi-info`, and shell completions (Bash, Zsh, Fish) into `~/.local/bin/` and `~/.local/share/`.

### Option 2: System-wide Installation
```bash
sudo make install PREFIX=/usr/local
```

### Option 3: Run directly from repository
```bash
./wifi-diag
# or using the bash companion:
./wifi-diag.sh
```

---

## 📖 Usage & Options

```bash
wifi-diag [options]
```

| Option | Description |
|---|---|
| *(none)* | Show full Wi-Fi diagnostic dashboard and health score |
| `-w, --watch [SEC]` | Live monitor mode with sparklines, bandwidth delta, and roam alerts |
| `-c, --channels, --advisor` | Channel congestion and RF interference advisor |
| `-m, --mesh, --roam` | Inspect all mesh / multi-AP nodes for current SSID and signal deltas |
| `-t, --test, --ping-test` | Run jitter, packet loss, and stability stress test |
| `--log FILE, --survey FILE` | Walk-test site survey CSV logger |
| `-s, --scan` | Scan and list nearby Wi-Fi access points |
| `-j, --json` | Output full diagnostics in structured JSON |
| `-1, --one-line` | Compact one-line status string (for status bars / tmux) |
| `-i, --interface IFACE` | Target specific wireless interface (default: auto-detect) |
| `--no-ping` | Skip ping checks for instant output |
| `--no-color` | Disable ANSI terminal color codes |
| `-v, --version` | Display version information |
| `-h, --help` | Display help message and options |

---

## 💡 Examples

### 1. Channel Congestion Advisor
```bash
wifi-diag -c
```
```text
  2.4 GHz Band Distribution:
    Channel  1 : ████████████    Crowded (12 APs)
    Channel  3 : █               Clean / Low Traffic
    Channel  6 : ███             Moderate
    Channel 11 : █               Clean / Low Traffic
    ↳ Recommendation: Best non-overlapping 2.4 GHz channel: Channel 11

  5 GHz Band Distribution:
    Channel  36 : ██              Moderate (2 APs)
    Channel 149 : ██████████████  Crowded (16 APs) [CURRENT]
    ↳ Recommendation: Consider UNII-1/2 Channels (e.g. Channel 36) for less interference.
```

### 2. Mesh & Multi-AP Node Inspector
```bash
wifi-diag -m
```
```text
Mesh & Multi-AP Nodes for SSID 'RCMP_mobile' (9 nodes detected):

STATE         BSSID               BAND      CHAN   FREQ       SIGNAL        DELTA      NOTES
────────────────────────────────────────────────────────────────────────────────────────────
[CONNECTED]   e8:d3:eb:da:29:07   5 GHz     149    5745 MHz   ▂▄▆█  94%     Active     Current Connected Node
[AVAILABLE]   40:47:5e:45:dc:86   2.4 GHz   1      2412 MHz   ▂▄▆█  95%     +1%        Nearby node
[AVAILABLE]   40:47:5e:45:dc:87   5 GHz     149    5745 MHz   ▂▄▆█  94%     Equal      Equal signal
[AVAILABLE]   28:ec:22:bb:8c:86   2.4 GHz   1      2412 MHz   ▂▄▆█  84%     -10%       Weaker node
```

### 3. Jitter & Stability Stress Test
```bash
wifi-diag -t
```
```text
TARGET                       MIN       AVG       MAX       JITTER (mdev)   LOSS     GRADE
──────────────────────────────────────────────────────────────────────────────────────────────
Local Gateway (Router)          7.6 ms   10.7 ms   14.2 ms ±1.99 ms        0%       A+ (Ultra Stable)
Internet DNS (Cloudflare)      68.6 ms   85.4 ms  139.5 ms ±19.12 ms       0%       C (Moderate Jitter)
```

### 4. Live Monitor with Rolling Sparklines
```bash
wifi-diag -w
```
```text
  Live Real-Time Trends:
    Signal Trend   : [-49 dBm]  ▃▅▆▇██▇▆▃▂▆█  (Min: -56, Max: -45 dBm)
    Gateway Jitter : [ 8.5 ms]   ▂ _   _ █ _  (Avg: 9.1ms, Jitter: ±1.8ms)
    Transfer Rate  : ↓ 1.25 MB/s   ↑ 140 KB/s
```

### 5. Site Survey Walk-Test CSV Logger
Walk around your space while logging Wi-Fi metrics every 2 seconds:
```bash
wifi-diag -w 2 --log survey.csv
```

### 6. Status Bar Integration (Polybar / Waybar / Tmux)
```bash
wifi-diag -1
# Output: RCMP_mobile | 5 GHz Ch149 | -49dBm (100%) | RX:1081M TX:721M | 192.168.1.164 (6.3ms)
```

---

## 🔧 Requirements
- Linux OS
- Python 3.6+ (standard library only)
- Wireless tools: `iw` and `nmcli` (NetworkManager) or `iproute2`
