# BOT JUALAN VPS — GEN SSH STORE 🚀

Bot Telegram untuk jualan VPS dengan pembayaran **QRIS manual** + konfirmasi admin.

## ✨ Fitur

- Menu utama **inline button** premium (pesan di-edit, bukan spam chat)
- Katalog produk yang bisa dikelola dari menu admin
- Alur order lengkap: pilih produk → QRIS → kirim bukti → admin approve
- Admin kirim detail VPS (IP, User, Password, Port) otomatis ke pelanggan
- `/start` ulang → pesan lama **otomatis dihapus**
- Pesan **data VPS tidak dihapus** (permanen di chat pelanggan)
- Format pesan HTML rapi (blockquote, bold, code)
- Data tersimpan di `database/db.json`

## 📋 Kebutuhan

- Node.js v18+ (disarankan v20/v22)
- Token bot Telegram dari [@BotFather](https://t.me/BotFather)
- ID Telegram admin (cek di [@userinfobot](https://t.me/userinfobot))

## 🚀 Cara Install

```bash
# 1. Install dependency
npm install

# 2. Buat file .env dari contoh
cp .env.example .env
nano .env        # isi BOT_TOKEN, ADMIN_IDS, dll

# 3. Jalankan bot
npm start
```

## ⚙️ Konfigurasi (.env)

| Variabel      | Keterangan                        | Contoh                  |
|---------------|-----------------------------------|-------------------------|
| `BOT_TOKEN`   | Token bot dari BotFather           | `123456:ABC-xxx`        |
| `ADMIN_IDS`   | ID admin, pisah koma jika banyak   | `7761880504,123456789`  |
| `SUPPORT`     | Username kontak support            | `@gensshstore`          |
| `STORE_NAME`  | Nama toko                          | `GEN SSH STORE`         |

## 🎮 Perintah

**User:**
- `/start` — Menu utama
- `/produk` — Lihat katalog
- `/order` — Beli VPS

**Admin:**
- `/admin` — Menu admin (tombol)
- `/kirim ORDERID IP USER PASS PORT` — Kirim detail VPS ke pembeli

## 📦 Alur Pesanan

1. Pelanggan pilih produk & bayar via QRIS
2. Kirim screenshot bukti ke bot
3. Admin dapat notifikasi + tombol **✅ Proses / ❌ Tolak**
4. Admin klik Proses → pelanggan dapat notif *"diproses 10–15 menit"*
5. Admin siapkan VPS, kirim `/kirim ORDERID IP USER PASS PORT`
6. Detail VPS otomatis terkirim ke pelanggan

## 🔄 Menjalankan 24 Jam (VPS)

**Opsi A — PM2 (recommended):**
```bash
npm install -g pm2
pm2 start ecosystem.config.js
pm2 save
pm2 startup
```

**Opsi B — Screen:**
```bash
screen -dmS botvps bash -c 'cd $(pwd) && node index.js > bot.log 2>&1'
```

**Opsi C — systemd:**
```bash
sudo cp deploy/botvps.service /etc/systemd/system/
# edit WorkingDirectory & ExecStart sesuai lokasi
sudo systemctl enable --now botvps
```

**Opsi D — Script cepat:**
```bash
bash run.sh
```

## 🔐 Keamanan

⚠️ **JANGAN** commit file `.env` ke GitHub — sudah masuk `.gitignore`.
Token bot hanya disimpan di `.env` (lokal) atau Environment Variables server.

---

Script by **GEN SSH STORE**
