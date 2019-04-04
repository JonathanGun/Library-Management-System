unit uload;
{Membaca file-file yang dibutuhkan program utama}

interface
const
	LOADMAXWORD = 1000;

procedure loadbook(filename: string; ptr: pbook);
procedure loaduser(filename: string; ptr: puser);
procedure loadborrow(filename: string; ptr: pborrow);
procedure loadreturn(filename: string; ptr: preturn);
procedure loadmissing(filename: string; ptr: pmissing);


implementation
uses
	sysutils,
	ubook,
	uuser,
	udate,
	umissing_history,
	uborrow_history,
	ureturn_history;

type
	{Definisi ADT input dari file}
	inputStream = array[1..LOADMAXWORD] of string;

	{pointer dari array inputStream}
	pinput = ^inputStream;


function readInput(filename: string; delimiter: char): pinput;
	{DESKRIPSI	: membaca file teks dan memuat ke dalam array agar dapat
	digunakan program/unit lain}
	{PARAMETER 	: nama file (beserta extensionnya) dan karakter delimiter
	(pemisah masing-masing kolom), pada kasus ini (CSV), adalah koma ','}
	{RETURN 	: pointer dari ADT inputStream}

	{KAMUS LOKAL}
	var
		f 			: text;
		readline 	: string;
		filetext 	: inputStream;
		wordcnt, i 	: integer;
		ptr 		: pinput;

	{ALGORITMA}
	begin
		{KONSTRUKTOR, set isi array menjadi string kosong}
		for i:= 1 to LOADMAXWORD do begin
			filetext[i] := '';
		end;

		{memuat file ke variabel f}
		system.assign(f, filename);
		system.reset(f);

		{membaca isi file csv}
		wordcnt := 0;
		while not EOF(f) do begin {ulangi selama belum EOF/EndOfFile}
			readln(f, readline);
			inc(wordcnt);

			{baca input per baris, increment index jika menemui karakter delimiter}
			for i:= 1 to length(readline) do begin
				if not (readline[i] = delimiter) then begin
					filetext[wordcnt] += readline[i];
				end else begin
					inc(wordcnt);
				end;
			end;
		end;
		close(f);

		new(ptr);
		ptr^ := filetext;
		readInput := ptr;
	end;


procedure loadbook(filename: string; ptr: pbook);
	{DESKRIPSI	: Memuat file csv berisi data buku ke dalam array of ADT Buku}
	{PARAMETER	: namafile dan pointer dari array tsb}

	{KAMUS LOKAL}
	var
		ploadedcsv	: pinput;
		i, j 		: integer;
		column		: integer;

	begin
		ploadedcsv := readInput(filename);
		column := 6;
		for i:= column + 1 to LOADMAXWORD do begin
			j := (i div column);
			if ((i mod column) = 1) then begin
				ptr^[j].id 		:= StrToIntDef(ploadedcsv^[i], 0);
			end else if ((i mod column) = 2) then begin
				ptr^[j].title 	+= ploadedcsv^[i];
			end else if ((i mod column) = 3) then begin
				ptr^[j].author 	:= ploadedcsv^[i];
			end else if ((i mod column) = 4) then begin
				ptr^[j].qty 	:= StrToIntDef(ploadedcsv^[i], 0);
			end else if ((i mod column) = 5) then begin
				ptr^[j].year 	:= StrToIntDef(ploadedcsv^[i], 0);
			end else if ((i mod column) = 0) then begin
				ptr^[j].category := ploadedcsv^[i];
			end;
		end;
	end;


procedure loaduser(filename: string; ptr: puser);
	var
		ploadedcsv		: pinput;
		i, column, j 	: integer;

	begin
		ploadedcsv := readInput(filename);
		column := 5;
		for i:= column + 1 to LOADMAXWORD do begin
			j := (i div column);
			if ((i mod column) = 1) then begin
				ptr^[j].fullname 	:= ploadedcsv^[i];
			end else if ((i mod column) = 2) then begin
				ptr^[j].address 	:= ploadedcsv^[i];
			end else if ((i mod column) = 3) then begin
				ptr^[j].username 	:= ploadedcsv^[i];
			end else if ((i mod column) = 4) then begin
				ptr^[j].password 	:= ploadedcsv^[i];
			end else if ((i mod column) = 0) then begin
				ptr^[j].isAdmin 	:= ploadedcsv^[i] = 'Admin';
			end;
		end;
	end;


procedure loadborrow(filename: string; ptr: pborrow);
	var
		ploadedcsv		: pinput;
		i, column, j 	: integer;

	begin
		ploadedcsv := readInput(filename);
		column := 5;
		for i:= column + 1 to LOADMAXWORD do begin
			j := (i div column);
			if ((i mod column) = 1) then begin
				ptr^[j].username 	:= ploadedcsv^[i];
			end else if ((i mod column) = 2) then begin
				ptr^[j].id 		:= StrToIntDef(ploadedcsv^[i], 0);
			end else if ((i mod column) = 3) then begin
				ptr^[j].borrowDate	:= StrToDate_(ploadedcsv^[i]);
			end else if ((i mod column) = 4) then begin
				ptr^[j].returnDate := StrToDate_(ploadedcsv^[i]);
			end else if ((i mod column) = 0) then begin
				ptr^[j].isBorrowed := ploadedcsv^[i] = 'belum';
			end;
		end;
	end;


procedure loadreturn(filename: string; ptr: preturn);
	var
		ploadedcsv		: pinput;
		i, column, j	: integer;

	begin
		ploadedcsv := readInput(filename);
		column := 3;
		for i:= column + 1 to LOADMAXWORD do begin
			j := (i div column);
			if ((i mod column) = 1) then begin
				ptr^[j].username 	:= ploadedcsv^[i];
			end else if ((i mod column) = 2) then begin
				ptr^[j].id 		:= StrToIntDef(ploadedcsv^[i], 0);
			end else if ((i mod column) = 0) then begin
				ptr^[j].returnDate	:= StrToDate_(ploadedcsv^[i]);
			end;
		end;
	end;


procedure loadmissing(filename: string; ptr: pmissing);
	var
		ploadedcsv		: pinput;
		i, column, j	: integer;

	begin
		ploadedcsv := readInput(filename);
		column := 3;
		for i:= column + 1 to LOADMAXWORD do begin
			j := (i div column);
			if ((i mod column) = 1) then begin
				ptr^[j].username 	:= ploadedcsv^[i];
			end else if ((i mod column) = 2) then begin
				ptr^[j].id 		:= StrToIntDef(ploadedcsv^[i], 0);
			end else if ((i mod column) = 0) then begin
				ptr^[j].reportDate	:= StrToDate_(ploadedcsv^[i]);
			end;
		end;
	end;
end.