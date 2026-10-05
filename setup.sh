#!/usr/bin/env bash
# ============================================
#  SETUP.SH — Install otomatis di VPS baru
#  Pakai:  bash setup.sh
# ============================================
set -e

echo "═══════════════════════════════════"
echo "  SETUP BOT JUALAN VPS"
echo "═══════════════════════════════════"

# Cek node
if ! command -v node >/dev/null 2>&1; then
  echo "[*] Node.js tidak ada, installing..."
  if command -v apt >/dev/null 2>&1; then
    curl -fsSL https://deb.nodesource.com/setup_20.x | bash -
    apt-get install -y nodejs
  elif command -v dnf >/dev/null 2>&1; then
    dnf install -y nodejs
  else
    echo "[✗] Package manager tidak dikenali. Install Node.js manual: https://nodejs.org"
    exit 1
  fi
fi
echo "[✓] Node $(node -v)"

# Install deps
echo "[*] Install dependency..."
npm install

# Setup .env
if [ ! -f .env ]; then
  cp .env.example .env
  echo "[!] File .env dibuat dari contoh."
  echo "    → Edit dulu: nano .env  (isi BOT_TOKEN & ADMIN_IDS)"
  echo "    → Lalu jalankan: bash run.sh"
else
  echo "[✓] .env sudah ada"
  bash run.sh
fi

echo "═══════════════════════════════════"
echo "  SELESAI! 🚀"
echo "═══════════════════════════════════"
