unit usave;
{Menyimpan array of ADT masing-masing ke dalam file csv, contoh: array of ADT Buku}
{REFERENSI	: http://wiki.freepascal.org/File_Handling_In_Pascal
			  https://www.youtube.com/watch?v=AOYbfHHh4bE (Reading & Writing to CSV Files in Pascal by Holly Billinghurst)}

interface
uses
	k03_kel3_utils,
	ubook,
	uuser,
	udate;

{PUBLIC FUNCTIONS, PROCEDURE}
procedure savebook(filename: string; ptr: pbook);
procedure saveuser(filename: string; ptr: puser);
procedure saveborrow(filename: string; ptr: pborrow);
procedure savereturn(filename: string; ptr: preturn);
procedure savemissing(filename: string; ptr: pmissing);


implementation
{FUNGSI dan PROSEDUR}
procedure savebook(filename: string; ptr: pbook);
	{DESKRIPSI	: Menyimpan ADT array of Book ke dalam file csv}
	{I.S. 		: pointer pbook terdefinisi, array tbook terdefinisi}
	{F.S.		: file csv terbentuk/terupdate di direktori}
	{Proses 	: meminta input nama file, lalu menyimpan ADT array of Book ke dalam file csv}

	{KAMUS LOKAL}
	var
		row 	: integer;
		f 		: text;

	{ALGORITMA}
	begin
		{memuat file ke variabel f}
		assign(f, filename);
		rewrite(f);

		writeln(f, 'ID_Buku,Judul_Buku,Author,Jumlah_Buku,Tahun_Penerbit,Kategori');
		for row:= 1 to bookNeff do begin
			write(f, IntToStr(ptr^[row].id) + delimiter);
			write(f, ptr^[row].title + delimiter);
			write(f, ptr^[row].author + delimiter);
			write(f, IntToStr(ptr^[row].qty) + delimiter);
			write(f, IntToStr(ptr^[row].year) + delimiter);
			writeln(f, ptr^[row].category);;
		end;
		close(f);
	end;

procedure saveuser(filename: string; ptr: puser);
	{DESKRIPSI	: Menyimpan ADT array of User ke dalam file csv}
	{I.S. 		: pointer pUser terdefinisi, array tUser terdefinisi}
	{F.S.		: file csv terbentuk/terupdate di direktori}
	{Proses 	: meminta input nama file, lalu menyimpan ADT array of User ke dalam file csv}

	{KAMUS LOKAL}
	var
		row 		: integer;
		f 			: text;

	{ALGORITMA}
	begin
		{memuat file ke variabel f}
		system.assign(f, filename);
		system.rewrite(f);
		
		writeln(f, 'Nama,Alamat,Username,Password,Role');
		for row:= 1 to userNeff do begin
			write(f, ptr^[row].fullname + delimiter);
			write(f, ptr^[row].address + delimiter);
			write(f, ptr^[row].username + delimiter);
			write(f, ptr^[row].password + delimiter);
			if ptr^[row].isAdmin then begin
				writeln(f, 'Admin');
			end else begin
				writeln(f, 'Pengunjung');
			end;
		end;
		close(f);
	end;

procedure saveborrow(filename: string; ptr: pborrow);
	{DESKRIPSI	: Menyimpan ADT array of BorrowHistory ke dalam file csv}
	{I.S. 		: pointer pBorrow terdefinisi, array tBorrow terdefinisi}
	{F.S.		: file csv terbentuk/terupdate di direktori}
	{Proses 	: meminta input nama file, lalu menyimpan ADT array of BorrowHistory ke dalam file csv}

	{KAMUS LOKAL}
	var
		row 		: integer;
		f 			: text;

	{ALGORITMA}
	begin
		{memuat file ke variabel f}
		system.assign(f, filename);
		system.rewrite(f);

		writeln(f, 'Username,ID_Buku,Tanggal_Peminjaman,Tanggal_Batas_Pengembalian,Status_Pengembalian');
		for row:= 1 to borrowNeff do begin
			write(f, ptr^[row].username + delimiter);
			write(f, IntToStr(ptr^[row].id) + delimiter);
			write(f, DateToStr(ptr^[row].borrowDate) + delimiter);
			write(f, DateToStr(ptr^[row].returnDate) + delimiter);
			if ptr^[row].isBorrowed then begin
				writeln(f, 'belum');
			end else begin
				writeln(f, 'sudah');
			end;
		end;
		close(f);
	end;

procedure savereturn(filename: string; ptr: preturn);
	{DESKRIPSI	: Menyimpan ADT array of ReturnHistory ke dalam file csv}
	{I.S. 		: pointer pReturn terdefinisi, array tReturn terdefinisi}
	{F.S.		: file csv terbentuk/terupdate di direktori}
	{Proses 	: meminta input nama file, lalu menyimpan ADT array of ReturnHistory ke dalam file csv}

	{KAMUS LOKAL}
	var
		row 		: integer;
		f 			: text;

	{ALGORITMA}
	begin
		{memuat file ke variabel f}
		system.assign(f, filename);
		system.rewrite(f);

		writeln(f, 'Username,ID_Buku,Tanggal_Pengembalian');
		for row:= 1 to returnNeff do begin
			write(f, ptr^[row].username + delimiter);
			write(f, IntToStr(ptr^[row].id) + delimiter);
			writeln(f, DateToStr(ptr^[row].returnDate));
		end;
		close(f);
	end;

procedure savemissing(filename: string; ptr: pmissing);
	{DESKRIPSI	: Menyimpan ADT array of MissingBook ke dalam file csv}
	{I.S. 		: pointer pMissing terdefinisi, array tMissing terdefinisi}
	{F.S.		: file csv terbentuk/terupdate di direktori}
	{Proses 	: meminta input nama file, lalu menyimpan ADT array of MissingBook ke dalam file csv}

	{KAMUS LOKAL}
	var
		row 		: integer;
		f 			: text;

	{ALGORITMA}
	begin
		{memuat file ke variabel f}
		system.assign(f, filename);
		system.rewrite(f);

		writeln(f, 'Username,ID_Buku_Hilang,Tanggal_Laporan');
		for row:= 1 to missingNeff do begin
			write(f, ptr^[row].username, delimiter);
			write(f, IntToStr(ptr^[row].id), delimiter);
			writeln(f, DateToStr(ptr^[row].reportDate));
		end;
		close(f);
	end;
end.
