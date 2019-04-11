unit ubookio;
{Berisi fungsi (F05, F06, F07, F09) yang berhubungan dengan keluar masuknya buku di perpustakaan}
{REFERENSI : -}

interface
uses
	ubook, ubookutils,
	udate;

{PUBLIC FUNCTION, PROCEDURE}
procedure borrowBookUtil(pnewBorrow : psingleborrow; ptrborrow: pborrow; ptrbook: pbook); {F05}
procedure returnBookUtil(bookid : integer; username : string; ptrreturn : preturn; ptrborrow : pborrow; ptrbook : pbook); {F06}
procedure addMissingBookUtil(ptr : psinglemissing; ptrarray: pmissing); {F07}
procedure addNewBookUtil(ptr : psinglebook; ptrarray : pbook); {F09}
procedure addBookQtyUtil(id, qty : integer; ptr : pbook); {F10}

implementation
{FUNGSI dan PROSEDUR}
procedure borrowBookUtil(pnewBorrow : psingleborrow; ptrborrow: pborrow; ptrbook: pbook);
    {DESKRIPSI	: (F05) }
    {I.S		: }
    {F.S		: }
    {Proses     : }
    
    {KAMUS LOKAL}
    var
    	idx	: integer;

    {ALGORITMA}
    begin
    	idx	:= checklocation(pnewBorrow^.id, ptrbook);
    	if (ptrbook^[idx].qty > 0) then begin
	    	ptrborrow^[borrowNeff+1] := pnewBorrow^;
    		borrowNeff += 1;
	    	ptrbook^[idx].qty -= 1;
	    	
	    	writeln('Tersisa ', ptrbook^[idx].qty, ' buku ', ptrbook^[idx].title, '.');
			writeln('Terima kasih, ', pnewBorrow^.username, ', sudah meminjam buku ', ptrbook^[idx].title, '!');
	    end else begin
	    	writeln('Buku ', ptrbook^[idx].title, ' sedang habis!');
	    	writeln('Coba lain kali.');
	    end;
    end;

procedure returnBookUtil(bookid : integer; username : string; ptrreturn : preturn; ptrborrow : pborrow; ptrbook : pbook);
    {DESKRIPSI  : (F06) }
    {I.S        : }
    {F.S        : }
    {Proses     : }

    {KAMUS LOKAL}
    var
        newReturn   : ReturnHistory;
        borrowData  : BorrowHistory;
        tmp         : string;
        booktitle   : string;
        idx         : integer;
        selisih     : integer;

    {ALGORITMA}
    begin
        borrowData  := searchBorrow(bookid, username, ptrborrow);
        if (borrowData.username <> 'Anonymous') then begin
            idx         := checklocation(borrowData.id, ptrbook);
            booktitle   := ptrbook^[idx].title;
            writeln();
            writeln('Data peminjaman:');
            writeln('Username: ', borrowData.username);
            writeln('Judul buku: ', booktitle);
            writeln('Tanggal peminjaman: ', DateToStr(borrowData.borrowDate));
            writeln('Tanggal pengembalian: ', DateToStr(borrowData.returnDate));

            write('Masukkan tanggal hari ini (DD/MM/YYYY): '); readln(tmp);
            writeln();

            newReturn.username  := username;
            newReturn.id        := bookid;
            newReturn.returnDate:= StrToDate(tmp);

            ptrreturn^[returnNeff+1] := newReturn;
            returnNeff += 1;

            idx := checklocation(bookid, ptrbook);
            ptrbook^[idx].qty += 1;
            
            selisih := DateDifference(borrowData.returnDate, newReturn.returnDate);
            if (selisih < 0) then begin
                writeln('Terima kasih sudah meminjam.');
            end else begin
                writeln('Anda terlambat ', selisih, ' hari mengembalikan buku.');
                writeln('Anda terkena denda Rp', selisih * 2000, '.');
                writeln('Silakan bayar di loket.')
            end;
        end;
    end;

procedure addMissingBookUtil(ptr : psinglemissing; ptrarray : pmissing);
    {DESKRIPSI  : (F07) Menerima laporan buku hilang dengan menerima data id buku, judul buku, dan tanggal pelaporan}
    {I.S        : array of book terdefinisi, pointer terdefinisi (pointer pada book.csv)}
    {F.S        : data buku hilang tersimpan }
    {Proses     : }

    {ALGORITMA}
    begin
        ptrarray^[missingNeff + 1] := ptr^;
        missingNeff += 1;
        writeln('Laporan berhasil diterima');
    end;

procedure addNewBookUtil(ptr : psinglebook; ptrarray : pbook);
    {DESKRIPSI  : (F09) Menerima data buku baru dan memasukkannya ke book.csv,dengan menerima masukkan id buku, judul
                  pengarang,jumlah,tahun terbit,dan kategori}
    {I.S        : pointer buku dan array terdefinisi (pointer pada book.csv)}
    {F.S        : data buku baru tersimpan }
    {Proses     : }
    
    {ALGORITMA}
    begin
        ptrarray^[bookNeff+1]:= ptr^;
        bookNeff += 1;
        writeln('Buku berhasil ditambahkan ke dalam sistem!');
    end;

procedure addBookQtyUtil (id,qty : integer; ptr : pbook);
    {DESKRIPSI  : (F10) Menambahkan jumlah buku dengan skema searching pada id yang ingin ditambahkan pada book.csv}
    {I.S        : id dan qty yang bertipe integer dan Ptrbook (pointer pada book.csv)}
    {F.S        : Jumlah buku dari buku dengan ID tertentu berubah }
    {PROSES     : Mencari buku dengan ID tertentu dengan skema searching dan mengubah data qty pada buku ID tersebut}

    {KAMUS LOKAL}
    var
        i,idx : integer;
        found : boolean;
        
    {ALGORITMA}
    begin
        {INISIALISASI}
        i := 1;
        found := False;

        {SKEMA SEARCHING}
        while ((not found) and (i <= bookNeff)) do begin
            if (id = ptr^[i].id) then begin
                idx := i;
                found := True;
            end;
            i += 1;
        end;

        {TAHAP PENAMBAHAN JUMLAH BUKU}
        ptr^[idx].qty += qty;
        writeln();
        writeln('Pembaharuan jumlah buku berhasil dilakukan, total buku ', ptr^[idx].title, ' menjadi ', ptr^[idx].qty);
    end;

end.
