#!/bin/bash

set -e

echo "Starting system optimization process..."
sleep 2

main_clean() {
  echo "Removing cache files and temporary data..."
  find ~ -type f \( -path "*/Cache/*" -o -path "*/CacheStorage/*" -o -name "*cache*" -o -path "*/Trash/*" -o -path "*/.local/share/Trash/*" \) -exec rm -rf {} + 2>/dev/null || true
}

package_clean() {
  echo "Cleaning package manager caches..."
  which apt-get >/dev/null 2>&1 && sudo apt-get clean >/dev/null 2>&1
  which yum >/dev/null 2>&1 && sudo yum clean all >/dev/null 2>&1
  which dnf >/dev/null 2>&1 && sudo dnf clean all >/dev/null 2>&1
  which pacman >/dev/null 2>&1 && sudo pacman -Scc --noconfirm >/dev/null 2>&1
}

log_clean() {
  echo "Removing old log files..."
  find /var/log -name "*.log.*" -o -name "*.gz" -o -name "*.old" -exec sudo rm -rf {} + 2>/dev/null || true
}

main_clean
package_clean
log_clean

echo "Optimization complete. System resources have been freed."
