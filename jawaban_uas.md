# Business Pitch

## Jawaban UAS

# No 1

Mampu menunjukkan keseluruhan Use Case beserta ranking dari tiap Use Case dari produk digital:

- **Use case user**

| No. | Use Case                    | Deskripsi                                                                       | Prioritas | Class Terkait                |
| --- | --------------------------- | ------------------------------------------------------------------------------- | --------- | ---------------------------- |
| 1   | Mengirim Pesan              | Pengguna dapat mengirim pesan teks ke kontak lain.                              | Tinggi    | Message, ChatController      |
| 2   | Mengirim Gambar             | Pengguna dapat mengirim gambar ke kontak lain.                                  | Tinggi    | Message, ChatController      |
| 3   | Mengirim Video              | Pengguna dapat mengirim video ke kontak lain.                                   | Tinggi    | Message, ChatController      |
| 4   | Mengirim Pesan Suara        | Pengguna dapat mengirim pesan suara ke kontak lain.                             | Tinggi    | Message, ChatController      |
| 5   | Membuat Grup                | Pengguna dapat membuat grup obrolan dengan kontak.                              | Tinggi    | Group, GroupController       |
| 6   | Bergabung Grup              | Pengguna dapat bergabung dengan grup obrolan.                                   | Tinggi    | Group, GroupController       |
| 7   | Mengirim Lokasi             | Pengguna dapat mengirim lokasi ke kontak lain.                                  | Tinggi    | MapController                |
| 8   | Mengirim Kontak             | Pengguna dapat mengirim kontak ke kontak lain.                                  | Tinggi    | ChatContoller, Contact, User |
| 9   | Mengirim Dokumen            | Pengguna dapat mengirim dokumen ke kontak lain.                                 | Tinggi    | ChatContoller, File          |
| 10  | Mengirim Pesan Broadcast    | Pengguna dapat mengirim pesan broadcast ke beberapa kontak sekaligus.           | Tinggi    | ChatContoller                |
| 11  | Mengirim Pesan Otomatis     | Pengguna dapat mengatur pesan otomatis untuk memberikan respons cepat.          | Sedang    | Chat                         |
| 12  | Mengatur Profil             | Pengguna dapat mengatur foto profil, status, dan informasi profil lainnya.      | Sedang    | Profil,settings              |
| 13  | Mengatur Privasi            | Pengguna dapat mengatur pengaturan privasi, seperti status terlihat atau tidak. | Sedang    | Privasi, settings            |
| 14  | Mengatur Notifikasi         | Pengguna dapat mengatur pengaturan notifikasi, seperti nada dering atau getar.  | Sedang    | Notifikasi, settings         |
| 15  | Mengatur Status Teks        | Pengguna dapat mengatur status teks yang bisa dilihat oleh kontaknya.           | Sedang    | Status                       |
| 16  | Mengatur Status Gambar      | Pengguna dapat mengatur status dengan menggunakan gambar.                       | Sedang    | Status                       |
| 17  | Mengatur Status Video       | Pengguna dapat mengatur status dengan menggunakan video.                        | Sedang    | Status                       |
| 18  | Mengatur Status GIF         | Pengguna dapat mengatur status dengan menggunakan GIF animasi.                  | Sedang    | Status                       |
| 19  | Mengatur Status Audio       | Pengguna dapat mengatur status dengan menggunakan audio.                        | Sedang    | Status                       |
| 20  | Mengatur Status Tautan      | Pengguna dapat mengatur status dengan menggunakan tautan.                       | Sedang    | Status                       |
| 21  | Mengubah Tema               | Pengguna dapat mengubah tema tampilan aplikasi WhatsApp.                        | Rendah    | Tampilan                     |
| 22  | Mengarsipkan Pesan          | Pengguna dapat mengarsipkan pesan untuk menyimpannya tanpa menghapusnya.        | Rendah    | Pesan                        |
| 23  | Membuat Cadangan Pesan      | Pengguna dapat membuat cadangan pesan untuk menyimpannya secara terpisah.       | Rendah    | Cadangan                     |
| 24  | Menggunakan Fitur Panggilan | Pengguna dapat melakukan panggilan suara dan video dengan kontak lain.          | Rendah    | Panggilan                    |
| 25  | Mengirim Stiker             | Pengguna dapat mengirim stiker ke kontak lain.                                  | Rendah    | Stiker                       |
| 26  | Registrasi                  | Pengguna dapat mendaftar ke aplikasi.                                           | tinggi    | User, AuthController         |

- **Use case manajemen perusahaan**

| No. | Use Case                     | Deskripsi                                                                                             | Prioritas |
| --- | ---------------------------- | ----------------------------------------------------------------------------------------------------- | --------- |
| 1   | Membuat Akun                 | Manajer perusahaan dapat membuat akun perusahaan di WhatsApp.                                         | Tinggi    |
| 2   | Mengelola Pengguna           | Manajer perusahaan dapat mengelola pengguna yang terdaftar di akun perusahaan.                        | Tinggi    |
| 3   | Mengatur Hak Akses           | Manajer perusahaan dapat mengatur hak akses pengguna berdasarkan peran mereka.                        | Tinggi    |
| 4   | Mengirim Pesan Massal        | Manajer perusahaan dapat mengirim pesan massal ke seluruh pengguna perusahaan.                        | Tinggi    |
| 5   | Mengelola Grup               | Manajer perusahaan dapat membuat, mengelola, dan mengatur grup obrolan perusahaan.                    | Tinggi    |
| 6   | Mengirim Pengumuman          | Manajer perusahaan dapat mengirim pengumuman penting kepada seluruh pengguna.                         | Sedang    |
| 7   | Mengelola Kontak             | Manajer perusahaan dapat mengelola daftar kontak perusahaan.                                          | Sedang    |
| 8   | Mengintegrasikan Sistem      | Manajer perusahaan dapat mengintegrasikan WhatsApp dengan sistem perusahaan lainnya.                  | Sedang    |
| 9   | Mengatur Pengaturan Keamanan | Manajer perusahaan dapat mengatur pengaturan keamanan seperti enkripsi dan verifikasi dua faktor.     | Sedang    |
| 10  | Melacak Aktivitas            | Manajer perusahaan dapat melacak aktivitas pengguna seperti pesan yang dikirim dan diterima.          | Sedang    |
| 11  | Mengelola Riwayat Pesan      | Manajer perusahaan dapat mengelola dan menyimpan riwayat pesan perusahaan.                            | Rendah    |
| 12  | Mengelola Pelaporan          | Manajer perusahaan dapat mengakses dan mengelola pelaporan terkait penggunaan WhatsApp di perusahaan. | Rendah    |

- **Use case direksi perusahaan (dashboard, monitoring, analisis)**

| No. | Use Case                           | Deskripsi                                                                                                                                                     | Prioritas |
| --- | ---------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------- | --------- |
| 1   | Melihat Dashboard                  | Direksi perusahaan dapat melihat dashboard yang memberikan gambaran menyeluruh tentang kinerja perusahaan dalam aplikasi WhatsApp.                            | Tinggi    |
| 2   | Memonitor KPI Perusahaan           | Direksi perusahaan dapat memonitor Key Performance Indicators (KPI) perusahaan dalam aplikasi WhatsApp.                                                       | Tinggi    |
| 3   | Memonitor Penggunaan Aplikasi      | Direksi perusahaan dapat memonitor penggunaan aplikasi WhatsApp oleh pengguna perusahaan dalam aplikasi WhatsApp.                                             | Sedang    |
| 4   | Memonitor Kinerja Grup             | Direksi perusahaan dapat memonitor kinerja grup obrolan dalam aplikasi WhatsApp yang digunakan oleh pengguna perusahaan.                                      | Sedang    |
| 5   | Memonitor Kinerja Panggilan        | Direksi perusahaan dapat memonitor kinerja panggilan suara dan video dalam aplikasi WhatsApp.                                                                 | Sedang    |
| 6   | Menganalisis Data Pengguna         | Direksi perusahaan dapat menganalisis data pengguna WhatsApp, seperti demografi pengguna, preferensi pengguna, dan perilaku pengguna dalam aplikasi WhatsApp. | Tinggi    |
| 7   | Melihat Laporan Aktivitas Pengguna | Direksi perusahaan dapat melihat laporan aktivitas pengguna dalam aplikasi WhatsApp, seperti jumlah pesan yang dikirim dan diterima.                          | Sedang    |
| 8   | Memonitor Keamanan dan Kepatuhan   | Direksi perusahaan dapat memonitor keamanan dan kepatuhan penggunaan aplikasi WhatsApp dalam perusahaan.                                                      | Tinggi    |
| 9   | Menganalisis Keterlibatan Pengguna | Direksi perusahaan dapat menganalisis tingkat keterlibatan pengguna dalam aplikasi WhatsApp, seperti jumlah pesan yang dibaca dan tanggapan pengguna.         | Sedang    |
| 10  | Melihat Laporan Pelaporan          | Direksi perusahaan dapat melihat laporan pelaporan terkait penggunaan WhatsApp di perusahaan, termasuk pelanggaran kebijakan dan masalah keamanan.            | Sedang    |

# No 2

Mampu mendemonstrasikan Class Diagram dari keseluruhan Use Case produk digital

# No 3

Mampu menunjukkan dan menjelaskan penerapan setiap poin dari SOLID Design Principle

# No 4

Mampu menunjukkan dan menjelaskan Design Pattern yang dipilih

# No 5

Mampu menunjukkan dan menjelaskan konektivitas ke database

# No 6

Mampu menunjukkan dan menjelaskan pembuatan web service dan setiap operasi CRUD nya

# No 7

Mampu menunjukkan dan menjelaskan Graphical User Interface dari
produk digital

# No 8

Mampu menunjukkan dan menjelaskan HTTP connection melalui GUI produk digital

# No 9

Mampu Mendemonstrsikan produk digitalnya kepada publik dengan cara-cara kreatif melalui video Youtube

# No 10

BONUS !!! Mendemonstrasikan penggunaan Machine Learning
