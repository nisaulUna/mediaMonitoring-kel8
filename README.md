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
