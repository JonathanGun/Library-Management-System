program main;
{Program Utama Sistem Manajemen Perpustakaan}
{Dibuat oleh KELOMPOK 3 KELAS 03}
{REFERENSI : https://tpb.kuliah.itb.ac.id/pluginfile.php/104511/mod_resource/content/1/IF1210_12_Skema_Standar_Bag2_040419.pdf (SkemaStandar Pemrosesan Array)
			 https://tpb.kuliah.itb.ac.id/pluginfile.php/10273/mod_resource/content/1/ContohPrgKecilPascal_Agt08.pdf (Contoh Program Kecil Bahasa Pascal)
			 https://www.tutorialspoint.com/pascal/pascal_pointers.htm
			 https://stackoverflow.com/questions/6320003/how-do-i-check-whether-a-string-exists-in-an-array}

uses
	uload,
	usave,
	ubook,
	F01, F02, F03, F04,f07,f08,f09,
	uuser,
	udate;

{KAMUS GLOBAL}
var
	books		: tbook;
	users		: tuser;
	borrows 	: tborrow;
	returns 	: treturn;
	missings	: tmissing;

	ptrbook 	: pbook;
	ptruser		: puser;
	ptrborrow	: pborrow;
	ptrreturn	: preturn;
	ptrmissing	: pmissing;

	activeUser	: User;
	query		: string;
	notAdminMsg	: string;
	i : integer;


{FUNGSI DAN PROSEDUR}
procedure printFeatures();
	{DESKRIPSI	: (F00) menampilkan fitur-fitur pada layar}
	{I.S. 			: Sembarang}
	{F.S.			 	: Fitur-fitur tertulis di layar}
	{Proses 		: Menulis fitur-fitur di layar}

	{ALGORITMA}
	begin
		writeln();
		writeln('Selamat datang di Perpustakaan Tengah Gurun');
		writeln('$ register			: Regitrasi Akun');
		writeln('$ login 			: Login');
		writeln('$ logout			: Logout');
		writeln('$ cari				: Pencarian Buku berdasar Kategori');
		writeln('$ caritahunterbit 		: Pencarian Buku berdasar Tahun Terbit');
		writeln('$ pinjam_buku 			: Pemimjaman Buku');
		writeln('$ kembalikan_buku 		: Pengembalian Buku');
		writeln('$ lapor_hilang			: Melaporkan Buku Hilang');
		writeln('$ lihat_laporan 		: Melihat Laporan Buku yang Hilang');
		writeln('$ tambah_buku 			: Menambahkan Buku Baru ke Sistem');
		writeln('$ tambah_jumlah_buku 		: Melakukan Penambahan Jumlah Buku ke Sistem');
		writeln('$ riwayat 			: Melihat Riwayat Peminjaman');
		writeln('$ statistik 			: Melihat Statistik');
		writeln('$ load 				: Load File');
		writeln('$ save 				: Save File');
		writeln('$ cari_anggota 			: Pencarian Anggota');
		writeln('$ exit				: Exit');
	end;

procedure loadAllFiles();
	{DESKRIPSI	: (F13) meminta input nama file dari user kemudian membaca
	isi file tsb dan memuatnya pada array yang bersangkutan}
	{I.S. 			: Sembarang}
	{F.S.			 	: Semua array of ADT terisi sesuai input nama file}
	{Proses 		: Meminta input nama file dari user, lalu mengisi array of ADT}

	{KAMUS LOKAL}
	var
		filename	: string;

	{ALGORITMA}
	begin
		ptrbook^ 	:= books;
		ptruser^	:= users;
		ptrborrow^ 	:= borrows;
		ptrreturn^	:= returns;
		ptrmissing^	:= missings;

		write('Masukkan nama File Buku: '); readln(filename);
		loadbook(filename, ptrbook);
		books 		:= ptrbook^;

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

		writeln();
		write('File perpustakaan berhasil dimuat!');
	end;

procedure saveAllFiles();
	{DESKRIPSI	: (F14) meminta input nama file dari user kemudian mengisi
			  file tsb dengan array yang bersangkutan}
	{I.S. 		: Sembarang}
	{F.S.		: Semua array of ADT tersimpan dalam file sesuai input dari user}
	{Proses 	: Meminta input nama file, lalu menyimpan array of ADT dalam file tsb}

	{KAMUS LOKAL}
	var
		filename	: string;

	{ALGORITMA}
	begin
		books := ptrbook^;
		users := ptruser^;
		borrows := ptrborrow^ ;
		returns := ptrreturn^	;
		missings := ptrmissing^ ;

		write('Masukkan nama File Buku: '); readln(filename);
		savebook(filename, ptrbook);

		write('Masukkan nama File User: '); readln(filename);
		saveuser(filename, ptruser);

		write('Masukkan nama File Peminjaman: '); readln(filename);
		saveborrow(filename, ptrborrow);

		write('Masukkan nama File Pengembalian: '); readln(filename);
		savereturn(filename, ptrreturn);

		write('Masukkan nama File Buku Hilang: '); readln(filename);
		savemissing(filename, ptrmissing);

		writeln();
		write('Data berhasil disimpan!');
	end;

function queryValid(q : string): boolean;
	{DESKRIPSI	: mengecek apakah query yang dimasukkan user valid/tidak}
	{PARAMETER	: query input user }
	{RETURN 	: boolean apakah query valid }

	{KAMUS LOKAL}
	const
		queries : array [1..17] of string = ('register',
											 'login',
											 'cari',
											 'caritahunterbit',
											 'pinjam_buku',
											 'kembalikan_buku',
											 'lapor_hilang',
											 'lihat_laporan',
											 'tambah_buku',
											 'tambah_jumlah_buku',
											 'riwayat',
											 'statistik',
											 'load',
											 'save',
											 'cari_anggota',
											 'exit',
											 'logout');

	var
		str : string;

	{ALGORITMA}
	begin
		for str in queries do begin
			if q = str then begin
				exit(true);
			end;
		end;
		queryValid := false;
	end;

procedure init();
	{DESKRIPSI	: prosedur dijalankan sekali, yaitu pada awal program berjalan}
	{I.S. 		: Sembarang}
	{F.S.		: query terdefinisi, activeUser terdefinisi, pointer terdefinisi}
	{Proses 	: menginisiasi variabel-variabel yang akan digunakan pada program utama}

	{ALGORITMA}
	begin
		query := 'load';
		writeln('$ load');

		activeUser.username := 'Anonymous';
		activeUser.password	:= '12345678';
		activeUser.fullname	:= 'Anonymous';
		activeUser.address	:= '';
		activeUser.isAdmin	:= false;

		notAdminMsg := 'Akses ditolak. Anda bukan admin!';

		new(ptrbook);
		new(ptruser);
		new(ptrborrow);
		new(ptrreturn);
		new(ptrmissing);
	end;

procedure tambah_jumlah_buku();
	{DESKRIPSI	: (F10 - Melakukan penambahan jumlah buku ke sistem}
	{I.S. 		: Sembarang}
	{F.S.		: jumlah buku dengan id ID bertambah sebanyak qty}
	{Proses 	: Meminta input id buku dan jumlah yang ingin ditambahkan,
			  lalu menambahkan jumlah buku ber id ID}

	{KAMUS LOKAL}
	var
		ID, qty : integer;

	{ALGORITMA}
	begin
		if activeUser.isAdmin then begin
			write('Masukkan ID Buku: ');
			readln(ID);
			write('Masukkan jumlah buku yang ditambahkan: ');
			readln(qty);
			{Procedure penambahan jumlah buku sesuai dengan id dan qty}
			Add_book_qty(ID, qty, ptrbook);
		end else begin
			writeln(notAdminMsg);
		end;
	end;

procedure riwayat();
	{DESKRIPSI	: (F11)}
	{I.S. 		: }
	{F.S.		: }
	{Proses 	: }

	{KAMUS LOKAL}

	{KAMUS LOKAL}
	var
		username : string;

	{ALGORITMA}
	begin
		if activeUser.isAdmin then begin
			write('Masukkan username pengunjung: ');
			readln(username);
			writeln('Riwayat:');
			{Procedure penampilan riwayat seseorang dari username}
			Borrow_history(username, ptrbook, ptrborrow);
		end else begin
			writeln(notAdminMsg);
		end;
	end;

procedure statistik();
	{DESKRIPSI	: (F12)}
	{I.S. 		: }
	{F.S.		: }
	{Proses 	: }

	{KAMUS LOKAL}

	{ALGORITMA}
	begin
		if activeUser.isAdmin then begin
			{Procedure penampilan data statistik perpustakaan}
			Stats(ptrbook, ptruser);
		end else begin
			writeln(notAdminMsg);
		end;
	end;

procedure find();
	{DESKRIPSI	: (F15) mencari anggota dengan username sesuai input dari user}
	{I.S. 		: array of User terdefinisi}
	{F.S.		: nama dan alamat user yang dicari tertulis di layar}
	{Proses 	: Menanyakan pada user username siapa yang akan dicari, lalu mencari username dan alamat user tersebut
				lalu menampilkannya di layar}

	var
		targetUsername 	: string;
		targetUser 			: User;
	begin
		if activeUser.isAdmin then begin
			write('Masukkan username: ');
			readln(targetUsername);
			targetUser := findUser(targetUsername, ptruser);
			writeln('Nama Anggota 	:', targetUser.fullname);
			writeln('Alamat anggota :', targetUser.address);
		end else begin
			writeln(notAdminMsg);
		end;
	end;

procedure exitProgram();
	{DESKRIPSI	: (F16) prosedur dijalankan sekali, yaitu saat menerima query exit}
	{I.S. 		: array of ADT terdefinisi}
	{F.S.		: keluar dari program dan file data tersimpan dalam format csv}
	{Proses 	: Menanyakan pada user apakah ingin menyimpan file, lalu menyimpan file,
			  lalu keluar dari program}

	{KAMUS LOKAL}
	var
		wantSave: char;

	{ALGORITMA}
	begin
		{Validasi Input}
		repeat
			writeln('Simpan data? (Y/N)');
			write('$ '); readln(wantSave);
		until (wantSave = 'Y') or (wantSave = 'y') or (wantSave = 'N') or (wantSave = 'n');
		writeln();

		{Save file sebelum program ditutup}
		if (wantSave = 'Y') or (wantSave = 'y') then begin
			writeln('$ save');
			saveAllFiles();
			writeln();
		end;

		write('Press ENTER to close program'); readln();
		exit();
	end;

procedure caritahunterbit();
	{DESKRIPSI	: (F04)}
	{I.S. 		: }
	{F.S.		: }
	{Proses 	: }

	{KAMUS LOKAL}
	var
		year 		: integer;
		category 	: string;
	
	{ALGORITMA}
	begin
		write('Masukkan tahun: '); readln(year);
		write('Masukkan kategori: ');readln(category);
		findbookbycategory(year, category, ptrbook);
	end;

procedure registeruser();
	{DESKRIPSI	: (F01)}
	{I.S. 		: }
	{F.S.		: }
	{Proses 	: }

	{KAMUS LOKAL}
	var
		pengunjung : user;

	{ALGORITMA}
	begin
		if activeUser.isAdmin then begin
			write('Masukkan nama pengunjung:');
			readln(pengunjung.fullname);
		
			write('Masukkan alamat pengunjung:');
			readln(pengunjung.address);
		
			write('Masukkan username pengunjung:');
			readln(pengunjung.username);
		
			write('Masukkan password pengunjung:');
			readln(pengunjung.password);

			userregistration (pengunjung, ptruser);
			writeln('Pengunjung ', pengunjung.fullname , ' berhasil terdaftar sebagai user.');
		end else begin
			writeln (notAdminMsg)
		end;	
	end;

procedure login();
	{DESKRIPSI	: (F02)}
	{I.S. 		: }
	{F.S.		: }
	{Proses 	: }

	{KAMUS LOKAL}
	var
		pengunjung : user;

	begin
		write('Masukkan username:');
		readln(pengunjung.username);
		
		write('Masukkan password:');
		readln(pengunjung.address);

		activeUser := loginuser (pengunjung, ptruser);
		if activeUser.username <> 'Anonymous' then begin
			writeln ('Selamat datang ', activeUser.fullname , '!');
		end else begin
			writeln ('Username / password salah! Silakan coba lagi.');
		end;
	end;	

procedure logout();
	{DESKRIPSI	: (T01)}
	{I.S. 		: }
	{F.S.		: }
	{Proses 	: }

	{KAMUS LOKAL}
	var
		wantLogout	: char;

	{ALGORITMA}
	begin
		{Validasi Input}
		repeat
			writeln('Yakin? (Y/N)');
			write('$ '); readln(wantLogout);
		until (wantLogout = 'Y') or (wantLogout = 'y') or (wantLogout = 'N') or (wantLogout = 'n');
		writeln();

		{Save file sebelum program ditutup}
		if (wantLogout = 'Y') or (wantLogout = 'y') then begin
			writeln('$ logout');

			activeUser.username := 'Anonymous';
			activeUser.password	:= '12345678';
			activeUser.fullname	:= 'Anonymous';
			activeUser.address	:= '';
			activeUser.isAdmin	:= false;

			writeln('Berhasil logout.'); 
			writeln ('Selamat datang ', activeUser.fullname , '!');
		end;
	end;


{ALGORITMA}
begin
	init();
	while not (query = 'exit') do begin
		case query of
			'register'				: registeruser();
			'login' 				: login();
			'cari' 					: findbookbyyear(ptrbook);
			'caritahunterbit' 		: caritahunterbit();
	{		// 'pinjam_buku' 			: pinjam_buku();}
	{		// 'kembalikan_buku' 		: kembalikan_buku();}
			'lapor_hilang'			: lapor_hilang(ptrmissing, activeUser.username);
	        'lihat_laporan' 		: lihat_laporan(ptrbook, ptrmissing);
			'tambah_buku' 			: tambah_buku(ptrbook);
			'tambah_jumlah_buku' 	: tambah_jumlah_buku();
			'riwayat' 				: riwayat();
			'statistik' 			: statistik();
			'load' 					: loadAllFiles();
			'save' 					: saveAllFiles();
			'cari_anggota' 			: find();
			'logout'				: logout();
		end;
		readln();

		printFeatures();
		write('$ '); readln(query); writeln();
		while not queryValid(query) do begin
			writeln('Command tidak terdaftar! Silahkan ulangi lagi!');
			write('$ '); readln(query); writeln();
		end;
	end;

	{DEBUG}
	writeln('======== DEBUG ========');
	writeln('BOOKS');
	for i:= 1 to bookNeff do writeln(books[i].id, ' ', books[i].title);
	writeln();

	writeln('USERS');
	for i:= 1 to userNeff do writeln(users[i].username, ' ', users[i].password);
	writeln();

	writeln('BORROWS');
	for i:= 1 to borrowNeff do writeln(borrows[i].username, ' ', borrows[i].borrowDate.year);
	writeln();

	writeln('RETURNS');
	for i:= 1 to returnNeff do writeln(returns[i].id, ' ', returns[i].returnDate.day);
	writeln();

	writeln('MISSINGS');
	for i:= 1 to missingNeff do writeln(missings[i].id, ' ', missings[i].username);
	writeln('======================');
	writeln();

	{EXIT}
	exitProgram();
end.
