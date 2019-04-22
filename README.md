# TUGAS BESAR DASAR PEMROGRAMAN
commited on : 2 April 2019

last edit   : 22 April 2019

## Deskripsi tugas:
Membuat program **sistem manajemen perpustakaan** dengan bahasa **Pascal**.

## Spesifikasi Program:
Memiliki 16 fitur wajib,
- [x] F01 - `register` (Registrasi akun)*
- [x] F02 - `login` (Login)
- [x] F03 - `cari` (Pencarian buku berdasarkan kategori)
- [x] F04 - `caritahunterbit` (Pencarian buku berdasarkan tahun terbit)
- [x] F05 - `pinjam_buku` (Peminjaman buku)
- [x] F06 - `kembalikan_buku` (Pengembalian buku)
- [x] F07 - `lapor_hilang` (Melaporkan buku hilang)
- [x] F08 - `lihat_laporan` (Melihat laporan buku yang hilang)*
- [x] F09 - `tambah_buku` (Menambahkan buku baru ke sistem)*
- [x] F10 - `tambah_jumlah_buku` (Melakukan penambahan jumlah buku ke sistem)*
- [x] F11 - `riwayat` (Melihat riwayat peminjaman)*
- [x] F12 – `statistik` (Statistik)*
- [x] F13 - `load` (Load file)*
- [x] F14 - `save` (Save file)*
- [x] F15 - `cari_anggota` (Pencarian anggota)*
- [x] F16 - `exit` (Exit)

2 fitur bonus,
- [x] B01 - Penyimpanan Password (menggunakan MD5)
- [x] B02 - Denda

dan 1 fitur tambahan.
- [x] T01 - `logout` (Logout)

*khusus admin

<br/><br/><br/>

Memiliki 5 struktur data eksternal dengan ekstensi **csv**,
- [x] File Buku (*ID_Buku,Judul_Buku,Author,Jumlah_Buku,Tahun_Penerbit,Kategori*)

ID_Buku | Judul_Buku | Author | Jumlah_Buku | Tahun_Penerbit | Kategori
------- | ---------- | ------ | ------------| -------------- | --------
1200 | "Pengantar Analisis Rangkaian" | "M.K. Sadiku" | 418 | 2015 | programming
1210 | "Dasar Pemrograman B" | "Inggriani Liem" | 419 | 2014 | programming
1101 | "Sejarah Olahraga Dasar" | "Jonathan" | 1 | 2007 | sejarah
7500 | "Naruto The Ultimate Edition" | "Masashi Kishimoto" | 79 | 2018 | manga
3450 | "Di Balik Sebuah Cerita" | "Mandala Rando" | 192 | 2017 | sastra

- [x] File User (*Nama,Alamat,Username,Password,Role*)

Username | ID_Buku_Hilang | Tanggal_Laporan
-------- | -------------- | ---------------
"jojojojojo" | 7500 | 14/04/2019
"michaellhans" | 1200 | 26/04/2019

- [x] File Histori Peminjaman (*Username,ID_Buku,Tanggal_Peminjaman,Tanggal_Batas_Pengembalian,Status_Pengembalian*)

Username | ID_Buku | Tanggal_Peminjaman | Tanggal_Batas_Pengembalian | Status_Pengembalian
-------- | ------- | ------------------ | ---------------------------| -------------------
"jojojojojo" | 7500 | 14/04/2019 | 21/04/2019 | sudah
"michaellhans" | 4500 | 14/04/2019 | 21/04/2019 | belum

- [x] File Histori Pengembalian (*Username,ID_Buku,Tanggal_Pengembalian*)

Username | ID_Buku | Tanggal_Pengembalian
-------- | ------- | --------------------
"jojojojojo" | 7500 | 25/04/2019

- [x] File Laporan Buku Hilang (*Username,ID_Buku_Hilang,Tanggal_Laporan*)

Nama | Alamat | Username | Password | Role
---- | ------ | -------- | -------- | ----
"Jojo" | "Padma" | "jojojojojo" | ec28f57b49dc8382660b7945d5795a71 | Admin
"Wan Shi Tong" | "Jl. Perpustakaan, Tengah Gurun 40135" | "wshitong997" | a7206de957142d005226b1af5e25d773 | Pengunjung
"Michael Hans" | "Jalan Cisitu Lama No. 36, Dago, Coblong" | "michaellhans" | ea503df530b682c3a7b43263a93e7a40 | Pengunjung
"asaa" | "jakarta" | "asaolv" | cf173a686221b935304947e60ab0d6d | Pengunjung

Memiliki format tanggal berupa *DD/MM/YYYY*

<br/><br/><br/>

## Changelog
**(05/04/2019) v0.2 Main program + (F13) Load file**
  - created unit templates and main.pas
  - finished uload.pas

**(05/04/2019) v0.3 (F14) Save file + (F16) Exit**
  - finished save.pas
  - added exit and save on exit
  - fixed DateToStr_ function on udate.pas

**(06/04/2019) v0.4 (F10) Tambah Jumlah Buku + (F11) Lihat Riwayat Peminjaman + (F12) Statistik + (F15) Pencarian Anggota**
  - added 3 functions on ubook.pas
  - added 1 functions on main.pas

**(07/04/2019) v0.9 All Basic Features minus F05 and F06**
  - added bunch of features, now nearly complete
 
**(07/04/2019) v0.9.1 Reformatting and Commenting, Minor Changes**
  - bug fix on riwayat, f09, statistik, etc

**(09/04/2019) v0.9.2 Denda**
  - added function for denda (on udate.pas)

**(11/04/2019) v1.0.0 Finished All Main Features**
  - new unit structures
  - remove sysutils dependencies
  - compacted code
  - universal commentary template

**(12/04/2019) v1.1.0 Hashing Complete**
  - using MD5 for hashing
  - a lot bug fixes on udate, csv file, uborrow, etc
  
**(13/04/2019) v1.2.0 CSV now support commas inside a cell**
  - address, name, username can contain commas and quotes inside them
 
**(14/04/2019) v1.2.1 Day count bug fixed**
  - fixed wrong return date
  - minor changes
  
**(15/04/2019) v1.2.2 Category and Year fixed**
  - categoryValidation solved
  - searchbyYear solved
 
 **(22/04/2019) v1.3.0 First Stable Version**
  - seluruh program sudah terdokumentasi
  - seluruh program sudah ditesting
  - seluruh program sudah dicek ulang penulisannya
  - minor fix (typo, dll)

<br/>

## Anggota Kelompok
- [Jonathan Yudi Gunawan](https://github.com/JonathanGun/)
- [Michael Hans](https://github.com/michaellhans)
- [Chandrika Azharyanti](https://github.com/cacachandrika)
- [Muhammad Azinul Haq](https://github.com/keltiga)
- [Ayutari Dian](https://github.com/ayutaridian)
