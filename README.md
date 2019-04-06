# TUGAS BESAR DASAR PEMROGRAMAN
commited on : 2 April 2019

last edit   : 6 April 2019

## Deskripsi tugas:
Membuat program **sistem manajemen perpustakaan** dengan bahasa **Pascal**.

## Spesifikasi Program:
Memiliki 16 fitur wajib,
- [ ] F01 - Registrasi akun
- [ ] F02 - Login
- [ ] F03 - Pencarian buku berdasarkan kategori
- [ ] F04 - Pencarian buku berdasarkan tahun terbit
- [ ] F05 - Peminjaman buku
- [ ] F06 - Pengembalian buku
- [ ] F07 - Melaporkan buku hilang
- [ ] F08 - Melihat laporan buku yang hilang
- [ ] F09 - Menambahkan buku baru ke sistem
- [x] F10 - Melakukan penambahan jumlah buku ke sistem
- [x] F11 - Melihat riwayat peminjaman
- [x] F12 – Statistik
- [x] F13 - Load file
- [x] F14 - Save file
- [x] F15 - Pencarian anggota
- [x] F16 - Exit

2 fitur bonus,
- [ ] B01 - Penyimpanan Password
- [ ] B02 - Denda

dan 1 fitur tambahan.
- [ ] T01 - Logout

Memiliki 5 struktur data eksternal dengan ekstensi **csv**,
- [x] File Buku (*ID_Buku,Judul_Buku,Author,Jumlah_Buku,Tahun_Penerbit,Kategori*)
- [x] File User (*Nama,Alamat,Username,Password,Role*)
- [x] File History Peminjaman (*Username,ID_Buku,Tanggal_Peminjaman,Tanggal_Batas_Pengembalian,Status_Pengembalian*)
- [x] File History Pengembalian (*Username,ID_Buku,Tanggal_Pengembalian*)
- [x] File Laporan Buku Hilang (*Username,ID_Buku_Hilang,Tanggal_Laporan*)

Memiliki format tanggal berupa *DD/MM/YYYY*

## Changelog
**v0.2 Main program + (F13) Load file eksternal**
  - created unit templates and main.pas
  - finished uload.pas

**v0.3 (F14) Save file + (F16) Exit**
  - finished save.pas
  - added exit and save on exit
  - fixed DateToStr_ function on udate.pas

**v0.4 (F10) Tambah Jumlah Buku + (F11) Lihat Riwayat Peminjaman + (F12) Statistik + (F15) Pencarian Anggota**
  - added 3 functions on ubook.pas
  - added 1 functions on main.pas

## Anggota Kelompok
- [Jonathan Yudi Gunawan](https://github.com/JonathanGun/)
- [Michael Hans](https://github.com/michaellhans)
- Chandrika Azharyanti
- Muhammad Azinul Haq
- Ayutari Dian
