#!/usr/bin/env bash
# ============================================
#  RUN.SH — Cara cepat menjalankan bot
#  Pakai:  bash run.sh          (jalankan)
#          bash run.sh stop     (matikan)
#          bash run.sh status   (cek status)
# ============================================
set -e

BOT_NAME="botvps"
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

# Muat .env jika ada
if [ -f "$SCRIPT_DIR/.env" ]; then
  export $(grep -v '^#' "$SCRIPT_DIR/.env" | xargs)
fi

if [ ! -d "$SCRIPT_DIR/node_modules" ]; then
  echo "[*] Installing dependencies..."
  cd "$SCRIPT_DIR" && npm install
fi

if [ ! -f "$SCRIPT_DIR/.env" ]; then
  echo "[!] File .env tidak ada. Copy dulu:  cp .env.example .env  lalu isi BOT_TOKEN"
  exit 1
fi

case "$1" in
  stop)
    pkill -f "node.*$SCRIPT_DIR/index.js" && echo "[✓] Bot dihentikan" || echo "[!] Bot tidak jalan"
    ;;
  status)
    pgrep -f "node.*$SCRIPT_DIR/index.js" >/dev/null && echo "[✓] Bot sedang JALAN" || echo "[✗] Bot MATI"
    ;;
  restart)
    bash "$0" stop || true
    sleep 1
    bash "$0"
    ;;
  *)
    cd "$SCRIPT_DIR"
    if command -v screen >/dev/null 2>&1; then
      echo "[*] Menjalankan bot di screen session '$BOT_NAME'..."
      screen -dmS "$BOT_NAME" bash -c "cd '$SCRIPT_DIR' && node index.js 2>&1 | tee bot.log"
      sleep 2
      pgrep -f "node.*index.js" >/dev/null && echo "[✓] Bot JALAN! Cek log: tail -f bot.log" || echo "[✗] Gagal start, cek bot.log"
    else
      echo "[*] Menjalankan bot langsung (Ctrl+C untuk stop)..."
      node index.js
    fi
    ;;
esac
