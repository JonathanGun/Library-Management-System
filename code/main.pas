program main;
{Program Utama Sistem Manajemen Perpustakaan}
{Dibuat oleh KELOMPOK 3 KELAS 03 DASPRO IF1210 STEI ITB 2018}
{REFERENSI : https://tpb.kuliah.itb.ac.id/pluginfile.php/104511/mod_resource/content/1/IF1210_12_Skema_Standar_Bag2_040419.pdf (SkemaStandar Pemrosesan Array)
			 https://tpb.kuliah.itb.ac.id/pluginfile.php/10273/mod_resource/content/1/ContohPrgKecilPascal_Agt08.pdf (Contoh Program Kecil Bahasa Pascal)
			 https://www.tutorialspoint.com/pascal/pascal_pointers.htm
			 https://stackoverflow.com/questions/6320003/how-do-i-check-whether-a-string-exists-in-an-array}

uses
	uload, usave, udate,
	ubook, ubooksearch, ubookio, ubookoutput,
	uuser, uuserutils,
	k03_kel3_utils, k03_kel3_md5;

{KAMUS GLOBAL}
var
	books			: tbook;
	users			: tuser;
	borrows 		: tborrow;
	returns 		: treturn;
	missings		: tmissing;
	
	ptrbook 		: pbook;
	ptruser			: puser;
	ptrborrow		: pborrow;
	ptrreturn		: preturn;
	ptrmissing		: pmissing;
	
	activeUser		: User;
	query			: string;
	notAdminMsg		: string;
	notLoggedInMsg	: string;
	ptractiveUser 	: psingleuser;

{FUNGSI DAN PROSEDUR}
procedure init();
	{DESKRIPSI	: prosedur dijalankan sekali, yaitu pada awal program berjalan}
	{I.S. 		: Sembarang}
	{F.S.		: query terdefinisi, activeUser terdefinisi, pointer terdefinisi}
	{Proses 	: menginisiasi variabel-variabel yang akan digunakan pada program utama}

	{ALGORITMA}
	begin
		query := 'load';
		writeln('$ load');

		new(ptrbook);
		new(ptruser);
		new(ptrborrow);
		new(ptrreturn);
		new(ptrmissing);
		new(ptractiveUser);

		ptractiveUser^ 	:= activeUser;
		setToDefaultUser(ptractiveUser);
		activeUser 		:= ptractiveUser^;
		notAdminMsg 	:= 'Akses ditolak. Anda bukan admin!';
		notLoggedInMsg 	:= 'Anda belum login. Silakan login terlebih dahulu';
	end;

procedure registerUser();
	{DESKRIPSI	: (F01)}
	{I.S. 		: }
	{F.S.		: }
	{Proses 	: }

	{KAMUS LOKAL}
	var
		newUser 	: user;
		pnewUser 	: psingleuser;

	{ALGORITMA}
	begin
		if (activeUser.isAdmin) then begin
			write('Masukkan nama pengunjung: '	  ); readln(newUser.fullname);
			write('Masukkan alamat pengunjung: '  ); readln(newUser.address);
			write('Masukkan username pengunjung: '); readln(newUser.username);
			write('Masukkan password pengunjung: '); readln(newUser.password);
			newUser.isAdmin := false;

			newUser.password := hashMD5(newUser.password);

			new(pnewUser);
			pnewUser^ := newUser;
			registerUserUtil(pnewUser, ptruser);
		end else begin
			writeln (notAdminMsg)
		end;	
	end;

procedure login();
	{DESKRIPSI	: (F02)}
	{I.S. 		: }
	{F.S.		: }
	{Proses 	: }

	begin
		write('Masukkan username: '); readln(activeUser.username);	
		write('Masukkan password: '); readln(activeUser.password);

		activeUser.password := hashMD5(activeUser.password);

		ptractiveUser^ := activeUser;
		loginUtil(ptractiveUser, ptruser);
		activeUser := ptractiveUser^;
	end;

procedure findBookByCategory();
	{DESKRIPSI	: (F03)}
	{I.S. 		: }
	{F.S.		: }
	{Proses 	: }

	{KAMUS LOKAL}
	var
		category: string;

	{ALGORITMA}
	begin
		writeln('Kategori Tersedia:');
		writeln('sastra');
		writeln('sains');
		writeln('manga');
		writeln('sejarah');
		writeln('programming');
		writeln();
		write('Masukkan kategori: '); readln(category);
		findBookByCategoryUtil(category, ptrbook);
	end;

procedure findBookByYear();
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
		write('Masukkan tahun: '   ); readln(year);
		write('Masukkan kategori: '); readln(category);
		findBookByYearUtil(year, category, ptrbook);
	end;

procedure borrowBook();
	{DESKRIPSI	: (F05)}
	{I.S. 		: }
	{F.S.		: }
	{Proses 	: }

	{KAMUS LOKAL}
	var
		newBorrow	: BorrowHistory;
		pnewBorrow	: psingleborrow;
		tmp 		: string;

	{ALGORITMA}
	begin
		if (activeUser.username <> 'Anonymous') then begin
			write('Masukkan id buku yang ingin dipinjam: '); readln(newBorrow.id);
			write('Masukkan tanggal hari ini (DD/MM/YYYY): '); readln(tmp);
			newBorrow.borrowDate := StrToDate(tmp);
			newBorrow.username 	 := activeUser.username;
			newBorrow.isBorrowed := true;
			newBorrow.returnDate := DaysToDate(DateToDays(newBorrow.borrowDate) + 7);

			new(pnewBorrow);
			pnewBorrow^ := newBorrow;
			borrowBookUtil(pnewBorrow, ptrborrow, ptrbook);
		end else begin
			writeln(notLoggedInMsg);
		end;
	end;

procedure returnBook();
	{DESKRIPSI	: (F06)}
	{I.S. 		: }
	{F.S.		: }
	{Proses 	: }

	{KAMUS LOKAL}
	var
		id: integer;

	{ALGORITMA}
	begin
		if (activeUser.username <> 'Anonymous') then begin
			write('Masukkan id buku yang ingin dikembalikan: '); readln(id);
			returnBookUtil(id, activeUser.username, ptrreturn, ptrborrow, ptrbook);
		end else begin
			writeln(notLoggedInMsg);
		end;
	end;


procedure addMissingBook();
	{DESKRIPSI	: (F07)}
	{I.S. 		: }
	{F.S.		: }
	{Proses 	: }

	{KAMUS LOKAL}
	var
		tmp 			: string;
		newMissingBook 	: MissingBook;
		ptrnewmissing 	: psinglemissing;

	{ALGORITMA}
	begin
		write('Masukkan id buku: '			); readln(newMissingBook.id);
		write('Masukkan judul buku: '		); readln();
		write('Masukkan tanggal pelaporan: '); readln(tmp);
		newMissingBook.reportDate 	:= StrToDate(tmp);
		newMissingBook.username 	:= activeUser.username;

		new(ptrnewmissing);
		ptrnewmissing^ := newMissingBook;
		addMissingBookUtil(ptrnewmissing, ptrmissing);
    end;

procedure showMissings();
	{DESKRIPSI	: (F08)}
	{I.S. 		: }
	{F.S.		: }
	{Proses 	: }

	{ALGORITMA}
	begin
		if (activeUser.isAdmin) then begin
			showMissingsUtil(ptrmissing, ptrbook);
		end else begin
			writeln(notAdminMsg);
		end;
	end;

procedure addNewBook();
	{DESKRIPSI	: (F09)}
	{I.S. 		: }
	{F.S.		: }
	{Proses 	: }

	{KAMUS LOKAL}
	var
		newBook 	: Book;
		pnewBook 	: psinglebook;

	{ALGORITMA}
	begin
		if (activeUser.isAdmin) then begin
	        writeln('Masukkan informasi buku yang ditambahkan:');
	        write('Masukkan id buku: '			); readln(newBook.id);
			write('Masukkan judul buku: '		); readln(newBook.title);
	        write('Masukkan pengarang buku: '	); readln(newBook.author);
	        write('Masukkan jumlah buku: '		); readln(newBook.qty);
	        write('Masukkan tahun terbit buku: '); readln(newBook.year);
	        write('Masukkan kategori buku: '	); readln(newBook.category);

	        new(pnewBook);
	        pnewBook^ := newBook;
			addNewBookUtil(pnewBook, ptrbook);
		end else begin
			writeln(notAdminMsg);
		end;
	end;

procedure addBookQty();
	{DESKRIPSI	: (F10) Melakukan penambahan jumlah buku ke sistem}
	{I.S. 		: Sembarang}
	{F.S.		: jumlah buku dengan id ID bertambah sebanyak qty}
	{Proses 	: Meminta input id buku dan jumlah yang ingin ditambahkan,
			  	  lalu menambahkan jumlah buku ber id ID}

	{KAMUS LOKAL}
	var
		ID, qty : integer;

	{ALGORITMA}
	begin
		if (activeUser.isAdmin) then begin
			write('Masukkan ID Buku: '); readln(ID);
			write('Masukkan jumlah buku yang ditambahkan: '); readln(qty);
			addBookQtyUtil(ID, qty, ptrbook);
		end else begin
			writeln(notAdminMsg);
		end;
	end;

procedure showBorrowHistory();
	{DESKRIPSI	: (F11)}
	{I.S. 		: }
	{F.S.		: }
	{Proses 	: }

	{KAMUS LOKAL}
	var
		username : string;

	{ALGORITMA}
	begin
		if (activeUser.isAdmin) then begin
			write('Masukkan username pengunjung: '); readln(username);
			writeln('Riwayat:');
			showBorrowHistoryUtil(username, ptrbook, ptrborrow);
		end else begin
			writeln(notAdminMsg);
		end;
	end;

procedure showStats();
	{DESKRIPSI	: (F12)}
	{I.S. 		: }
	{F.S.		: }
	{Proses 	: }

	{ALGORITMA}
	begin
		if (activeUser.isAdmin) then begin
			showStatsUtil(ptrbook, ptruser);
		end else begin
			writeln(notAdminMsg);
		end;
	end;


procedure loadAllFiles();
	{DESKRIPSI	: (F13) meminta input nama file dari user kemudian membaca
				  isi file tsb dan memuatnya pada array yang bersangkutan}
	{I.S. 		: Sembarang}
	{F.S.		: Semua array of ADT terisi sesuai input nama file}
	{Proses 	: Meminta input nama file dari user, lalu mengisi array of ADT}

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

		write('Masukkan nama File Buku: '		 ); readln(filename); loadbook(filename, ptrbook);
		write('Masukkan nama File User: '		 ); readln(filename); loaduser(filename, ptruser);
		write('Masukkan nama File Peminjaman: '	 ); readln(filename); loadborrow(filename, ptrborrow);
		write('Masukkan nama File Pengembalian: '); readln(filename); loadreturn(filename, ptrreturn);
		write('Masukkan nama File Buku Hilang: ' ); readln(filename); loadmissing(filename, ptrmissing);
		writeln();
		write('File perpustakaan berhasil dimuat!');

		books 		:= ptrbook^;
		users 		:= ptruser^;
		borrows 	:= ptrborrow^;
		returns 	:= ptrreturn^;
		missings	:= ptrmissing^;
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
		books 		:= ptrbook^;
		users 		:= ptruser^;
		borrows 	:= ptrborrow^;
		returns 	:= ptrreturn^;
		missings 	:= ptrmissing^;

		write('Masukkan nama File Buku: '		 ); readln(filename); savebook(filename, ptrbook);
		write('Masukkan nama File User: '		 ); readln(filename); saveuser(filename, ptruser);
		write('Masukkan nama File Peminjaman: '	 ); readln(filename); saveborrow(filename, ptrborrow);
		write('Masukkan nama File Pengembalian: '); readln(filename); savereturn(filename, ptrreturn);
		write('Masukkan nama File Buku Hilang: ' ); readln(filename); savemissing(filename, ptrmissing);
		writeln();
		write('Data berhasil disimpan!');
	end;

procedure findUser();
	{DESKRIPSI	: (F15) mencari anggota dengan username sesuai input dari user}
	{I.S. 		: array of User terdefinisi}
	{F.S.		: nama dan alamat user yang dicari tertulis di layar}
	{Proses 	: Menanyakan pada user username siapa yang akan dicari, lalu mencari username dan alamat user tersebut
				  lalu menampilkannya di layar}

	var
		targetUsername 	: string;

	begin
		if (activeUser.isAdmin) then begin
			write('Masukkan username: '); readln(targetUsername);
			findUserUtil(targetUsername, ptruser);
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
		clrscr_();
		writeln('$ exit');
		{Validasi Input}
		repeat
			writeln();
			writeln('Simpan data? (Y/N)');
			write('$ '); readln(wantSave);
		until ((wantSave = 'Y') or (wantSave = 'y') or (wantSave = 'N') or (wantSave = 'n'));
		writeln();

		{Save file sebelum program ditutup}
		if ((wantSave = 'Y') or (wantSave = 'y')) then begin
			writeln('$ save');
			saveAllFiles();
			writeln();
		end;

		write('Tekan ENTER untuk menutup program.'); readln();
		clrscr_();
	end;

procedure logout();
	{DESKRIPSI	: (T01) logout dari akun sekarang}
	{I.S. 		: sembarang (akan dilakukan validasi)}
	{F.S.		: activeUser menjadi default (anonymous)}
	{Proses 	: cek sudah login/belum, validasi input mau logout/tidak, set activeuser menjadi default}

	{KAMUS LOKAL}
	var
		wantLogout	: char;

	{ALGORITMA}
	begin
		if (activeUser.username <> 'Anonymous') then begin
			{Validasi Input}
			repeat
				writeln('Yakin? (Y/N)');
				write('$ '); readln(wantLogout);
			until ((wantLogout = 'Y') or (wantLogout = 'y') or (wantLogout = 'N') or (wantLogout = 'n'));
			writeln();

			{Save file sebelum program ditutup}
			if ((wantLogout = 'Y') or (wantLogout = 'y')) then begin
				clrscr_();
				writeln('$ logout');

				setToDefaultUser(ptractiveUser);
				activeUser := ptractiveUser^;

				writeln('Berhasil logout.'); 
				writeln('Selamat datang ', activeUser.fullname , '!');
			end;
		end else begin
			writeln(notLoggedInMsg);
		end;
	end;

{ALGORITMA}
begin
	init();
	while (not (query = 'exit')) do begin
		clrscr_(); writeln('$ ', query);
		case query of
			'register'				: registerUser();
			'login' 				: login();
			'cari' 					: findBookByCategory();
			'caritahunterbit' 		: findBookByYear();
			'pinjam_buku' 			: borrowBook();
			'kembalikan_buku' 		: returnBook();
			'lapor_hilang'			: addMissingBook();
	        'lihat_laporan' 		: showMissings();
			'tambah_buku' 			: addNewBook();
			'tambah_jumlah_buku' 	: addBookQty();
			'riwayat' 				: showBorrowHistory();
			'statistik' 			: showStats();
			'load' 					: loadAllFiles();
			'save' 					: saveAllFiles();
			'cari_anggota' 			: findUser();
			'logout'				: logout();
		end;
		writeln();write('Tekan ENTER untuk melanjutkan.'); readln(); clrscr_();

		printFeatures(ptractiveUser);
		write('$ '); readln(query); writeln();
		while (not queryValid(query)) do begin
			writeln('Command tidak terdaftar! Silahkan ulangi lagi!');
			write('$ '); readln(query);
			writeln();
		end;
	end;

	{EXIT}
	exitProgram();
end.
