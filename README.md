# 👥 Kelompok 8

| No | Nama Lengkap                             | NIM         |
|----|------------------------------------------|-------------|
| 1  | Nisaul Husna                             | 2210511055  |
| 2  | Intan Febyola Putri Dwina Sidabutar      | 2210511065  |
| 3  | Karenina Nurmelita Malik                 | 2210511089  |

---

# 📊 MediaScope – Media Monitoring App

**MediaScope** adalah aplikasi *media monitoring* yang dirancang untuk membantu pengguna dalam memantau, menganalisis, dan memahami berbagai informasi yang tersebar di media digital.  
Cukup dengan memasukkan satu **keyword**, sistem secara otomatis akan menampilkan hasil analisis dari berbagai platform media: **X (Twitter), YouTube**, dan **Google News**.

---

## 🌐 Integrasi API Eksternal

1. **Twitter API** – Mengambil tweet terbaru berdasarkan keyword proyek.  
2. **YouTube Data API (Google Cloud)** – Mengambil komentar dari video relevan.  
3. **Serper.dev API** – Mengambil berita dari hasil pencarian Google News.

---

## ⚙️ Background Workers

1. **mentionFetchWorker** – Mengambil data dari API eksternal setiap 5 menit.  
2. **backupWorker** – Melakukan backup otomatis seluruh data ke file JSON.  
3. **deleteProjectWorker** – Menghapus project tidak aktif setelah 7 hari, dengan reminder H-1 sebelum penghapusan permanen.

---

## 🛡️ Security

- ✅ **JWT Auth** – Proteksi akses menggunakan JSON Web Token.  
- ✅ **Hashed Password** – Password terenkripsi menggunakan bcrypt.  
- ✅ **SQL Injection Safe** – Aman dari SQL Injection dengan prepared statements.  
- ✅ **Rate Limiting** – Membatasi jumlah request login & register.  
- ✅ **Activity Logging** – Mencatat semua aktivitas penting secara otomatis.

---
## DAFTAR ENPOINT API

## 📌 API Sederhana (CRUD)

| No | Method | Endpoint                          | Deskripsi                                                            |
|----|--------|-----------------------------------|----------------------------------------------------------------------|
| 1  | GET    | `/search/result`                 | Mendapatkan detail semua project pengguna                           |
| 2  | GET    | `/search/result?project_name=...`| Mendapatkan detail satu project pengguna                            |
| 3  | GET    | `/search/mentions?project_name=...` | Mengambil semua hasil media mention suatu project                 |
| 4  | GET    | `/sentiment`                     | Mengambil sentimen per mentions                                     |
| 5  | GET    | `/positive-sentiment-summary`    | Mengambil jumlah total sentimen positif                             |
| 6  | GET    | `/negative-sentiment-summary`    | Mengambil jumlah total sentimen negatif                             |
| 7  | GET    | `/neutral-sentiment-summary`     | Mengambil jumlah total sentimen netral                              |
| 8  | GET    | `/backups`                       | Melihat semua file backup yang tersedia                             |
| 9  | GET    | `/backups/:name`                 | Melihat isi file backup tertentu                                    |
| 10 | DELETE | `/backups/:name`                 | Menghapus file backup tertentu                                      |
| 11 | PUT    | `/backups/:name`                 | Mengupdate isi file backup tertentu                                 |
| 12 | GET    | `/users`                         | Mengambil semua data pengguna                                       |
| 13 | GET    | `/users/detail`                  | Mengambil data pengguna yang sedang login                           |
| 14 | PUT    | `/users/update`                  | Memperbarui data pengguna yang sedang login                         |
| 15 | DELETE | `/users/delete`                  | Menghapus akun pengguna yang sedang login                           |
| 16 | GET    | `/users/logs`                    | Mengambil semua aktivitas login pengguna                            |
| 17 | GET    | `/reports`                       | Mengambil semua data laporan                                        |
| 18 | POST   | `/reports/create`                | Membuat laporan baru                                                |
| 19 | PUT    | `/reports/update`                | Memperbarui laporan yang tersedia                                   |
| 20 | DELETE | `/reports/delete`                | Menghapus laporan yang tersedia                                     |
| 21 | GET    | `/reminders`                     | Mengambil daftar pengingat sebelum project dihapus                  |
| 22 | GET    | `/keywords`                      | Ambil semua keyword                                                 |
| 23 | POST   | `/keywords`                      | Tambah keyword baru                                                 |
| 24 | PUT    | `/keywords/{id}`                 | Update keyword tertentu                                             |
| 25 | DELETE | `/keywords/{id}`                 | Hapus keyword tertentu                                              |

---

## 📌 API Complex

| No | Method | Endpoint                                                                                           | Deskripsi                                                                                  |
|----|--------|----------------------------------------------------------------------------------------------------|--------------------------------------------------------------------------------------------|
| 1  | GET    | `/search/mentions?project_name=...&source=...`                                                     | Ambil media mention berdasarkan platform (Twitter, YouTube, Google)                        |
| 2  | GET    | `/search/mentions?project_name=...&year=...`                                                       | Ambil media mention berdasarkan tahun (tidak berlaku untuk Google)                         |
| 3  | GET    | `/search/mentions?project_name=...&sentiment=...`                                                  | Ambil media mention berdasarkan sentimen (positive, negative, neutral)                    |
| 4  | GET    | `/search/mentions?project_name=...&language=...`                                                   | Ambil media mention berdasarkan bahasa konten (id, en, other)                             |
| 5  | GET    | `/search/mentions?project_name=...&source=...&year=...`                                            | Ambil media mention berdasarkan platform dan tahun (tidak berlaku untuk Google)           |
| 6  | GET    | `/search/mentions?project_name=...&language=...&sentiment=...`                                     | Ambil media mention berdasarkan bahasa dan sentimen (tidak mendukung "other")             |
| 7  | GET    | `/search/platform-summary?project_name=...`                                                        | Ambil jumlah media mention berdasarkan platform                                           |
| 8  | GET    | `/search/language-summary?project_name=...`                                                        | Ambil jumlah media mention berdasarkan bahasa                                              |
| 9  | GET    | `/search/sentiment-summary?project_name=...`                                                       | Ambil jumlah media mention berdasarkan kategori sentimen                                   |
| 10 | GET    | `/search/mentions?project_name=...&source=...&year=...&language=...&sentiment=...`                 | Ambil media mention berdasarkan kombinasi filter platform, tanggal, bahasa, dan sentimen  |
| 11 | POST   | `/auth/reset-password`                                                                             | Reset password menggunakan token                                                           |
| 12 | POST   | `/auth/forgot-password`                                                                            | Minta reset password (lupa password)                                                       |
| 13 | POST   | `/auth/logout`                                                                                     | Logout dari akun pengguna                                                                  |
| 14 | POST   | `/register`                                                                                        | Register pengguna baru dengan password yang di-hash menggunakan bcrypt                     |
| 15 | POST   | `/login`                                                                                           | Login dan dapatkan JWT token sebagai autentikasi                                           |


---

## 📌 API NoSQL (Redis)

| No | Method | Endpoint                                | Deskripsi                                                                 |
|----|--------|------------------------------------------|---------------------------------------------------------------------------|
| 1  | GET    | `/cache/keyword?keyword=...`             | Menyimpan keyword yang dimasukkan user ke Redis                          |
| 2  | GET    | `/cache/recent-deleted`                  | Mengambil daftar project yang baru saja dihapus                         |
| 3  | GET    | `/cache/top-searches`                    | Menampilkan 5 keyword pencarian terpopuler hari ini                     |
| 4  | GET    | `/cache/dashboard-summary`               | Ringkasan dashboard real-time dari Redis (total keyword, queue delete)  |
| 5  | GET    | `/cache/user-activity/:userId`           | Menampilkan 10 aktivitas terakhir user dari Redis                        |
| 6  | GET    | `/cache/cache-stats`                     | Statistik umum Redis (jumlah keyword, project terhapus, alert keyword)  |
| 7  | GET    | `/logs/email-logs`                       | Menampilkan 10 log pengiriman email terakhir dari Redis                  |
| 8  | GET    | `/logs/export-logs`                      | Menampilkan 10 log proses ekspor terakhir                                |
| 9  | GET    | `/logs/activity-logs`                    | Mengambil 10 log aktivitas user terbaru dari Redis                       |
| 10 | POST   | `/logs/email-logs`                       | Menyimpan log pengiriman email ke Redis                                  |
| 11 | POST   | `/logs/export-logs`                      | Menyimpan log proses ekspor file ke Redis                                |
| 12 | POST   | `/logs/activity-logs`                    | Menyimpan log aktivitas user (selain login) ke Redis                     |
