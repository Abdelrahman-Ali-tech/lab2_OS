# Antivirus Daemon & Restore Tool

## Overview
A simple Linux security system consisting of a monitoring daemon (`antivirusd.sh`) to detect and quarantine malicious files, and an interactive tool (`restore.sh`) to review quarantined items.

### Folder Structure

.
├── antivirusd.sh     # Monitoring daemon
├── restore.sh        # Interactive restore tool
├── Makefile          # Automation commands
└── README.md         # Project documentation

---

## Prerequisites
- Any standard Linux/Ubuntu environment with POSIX shell (`sh`) and basic tools (`diff`, `grep`, `make`).

---

## How to Run

1. **Build & Setup:**
   ```bash
   make build

 * Run Antivirus Daemon:
   make run
# Or directly: ./antivirusd.sh test_dir quarantine_dir 3

 * Run Restore Tool:
   make restore
# Or directly: ./restore.sh test_dir quarantine_dir

 * Clean Temporary Files:
   make clean

Flagged Lists Locations
 * Extensions (.exe, .bat, .vbs, .scr, .ps1): Defined inside antivirusd.sh in the case "$filename" in block.
 * Keywords (virus, trojan, malware, worm, ransomware): Defined inside antivirusd.sh in the grep command.
