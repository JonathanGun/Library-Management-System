program main;
{Program Utama Perpustakaan}
uses
	uload,
	ubook,
	uuser,
	udate,
	umissing_history,
	uborrow_history,
	ureturn_history;

{KAMUS}
var
	activeUser	: User;
	books		: tbook;
	users		: tuser;
	borrows 	: tborrow;
	returns 	: treturn;
	missings	: tmissing;
	query		: string;



{FUNGSI DAN PROSEDUR}
procedure printFeatures();
begin
	writeln('Selamat datang di Perpustakaan Tengah Gurun');
	writeln('$ register				: Regitrasi Akun');
	writeln('$ login 				: Login');
	writeln('$ cari 				: Pencarian Buku berdasar Kategori');
	writeln('$ caritahunterbit 		: Pencarian Buku berdasar Tahun Terbit');
	writeln('$ pinjam_buku 			: Pemimjaman Buku');
	writeln('$ kembalikan_buku 		: Pengembalian Buku');
	writeln('$ lapor_hilang			: Melaporkan Buku Hilang');
	writeln('$ lihat_laporan 		: Melihat Laporan Buku yang Hilang');
	writeln('$ tambah_buku 			: Menambahkan Buku Baru ke Sistem');
	writeln('$ tambah_jumlah_buku 	: Melakukan Penambahan Jumlah Buku ke Sistem');
	writeln('$ riwayat 				: Melihat Riwayat Peminjaman');
	writeln('$ statistik 			: Melihat Statistik');
	writeln('$ load 				: Load File');
	writeln('$ save 				: Save File');
	writeln('$ cari_anggota 		: Pencarian Anggota');
	writeln('$ exit					: Exit');
	write('$ ');
end;



procedure loadAllFiles();
var
	ptrbooks	: pbook;
	ptruser		: puser;
	ptrborrow	: pborrow;
	ptrreturn	: preturn;
	ptrmissing	: pmissing;
	filename	: string;
	i 			: integer;

begin
	new(ptrbooks);
	new(ptruser);
	new(ptrborrow);
	new(ptrreturn);
	new(ptrmissing);


	ptrbooks^ 	:= books;
	ptruser^	:= users;
	ptrborrow^ 	:= borrows;
	ptrreturn^	:= returns;
	ptrmissing^	:= missings;


	write('Masukkan nama File Buku: '); readln(filename);
	loadbook(filename, ptrbooks);
	books 		:= ptrbooks^;
	
	write('Masukkan nama File User: '); readln(filename);
	loaduser(filename, ptruser);
	users 		:= ptruser^;
	
	write('Masukkan nama File Peminjaman: '); readln(filename);
	loadborrow(filename, ptrborrow);
	borrows 	:= ptrborrow^;

	write('Masukkan nama File Pengembalian: '); readln(filename);
	loadreturn(filename, ptrreturn);
	returns 	:= ptrreturn^;

	write('Masukkan nama File Buku Hilang: '); readln(filename);
	loadmissing(filename, ptrmissing);
	missings	:= ptrmissing^;
end;



{ALGORITMA}
begin
	printFeatures(); readln(query); writeln(query);

	case query of
{		// 'register'				: register();}
{		// 'login' 				: login();}
{		// 'cari' 					: cari();}
{		// 'caritahunterbit' 		: caritahunterbit();}
{		// 'pinjam_buku' 			: pinjam_buku();}
{		// 'kembalikan_buku' 		: kembalikan_buku();}
{		// 'lapor_hilang'			: lapor_hilang();}
{		// 'lihat_laporan' 		: lihat_laporan();}
{		// 'tambah_buku' 			: tambah_buku();}
{		// 'tambah_jumlah_buku' 	: tambah_jumlah_buku();}
{		// 'riwayat' 				: riwayat();}
{		// 'statistik' 			: statistik();}
		'load' 					: loadAllFiles();
{		// 'save' 					: save();}
{		// 'cari_anggota' 			: cari_anggota();}
{		// 'exit'					: exit();}
	end;
end.
