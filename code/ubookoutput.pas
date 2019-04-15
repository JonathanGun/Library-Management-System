unit ubookoutput;
{Berisi fungsi (F08, F11, F12) yang mennampilkan isi berbagai ADT Buku ke layar}
{REFERENSI}

interface
uses
    ucsvwrapper,
    ubook, ubookutils,
    udate, uuser;

{PUBLIC, FUNCTION, PROCEDURE}
procedure showMissingsUtil(ptrmissing : pmissing; ptrbook : pbook); {F08}
procedure showStatsUtil(ptrbook : pbook; ptruser : puser); {F11}
procedure showBorrowHistoryUtil(username : string; ptrbook : pbook; ptrborrow : pborrow); {F12}

implementation
{FUNGSI dan PROSEDUR}
procedure showMissingsUtil(ptrmissing : pmissing; ptrbook : pbook);
    {DESKRIPSI  : (F08) Menampilkan data-data buku yang hilang}
    {I.S        : pointer menunjuk ke missing terdefinisi (pointer pada book.csv)}
    {F.S        : data buku hilang ditampilkan }
    {Proses     : menampilkan data-data buku hilang berdasarkan id dan tanggal dari ptrmissing, dan judul dari ptrbook}

    {KAMUS LOKAL}
    var
        idx, i  : integer;
    
    {ALGORITMA}
    begin
        for i:= 1 to missingNeff do begin
            idx := checklocation(ptrmissing^[i].id, ptrbook);
            writeln(ptrmissing^[i].id, ' | ', ptrbook^[idx].title, ' | ', DateToStr(ptrmissing^[i].reportdate));
        end;
    end;

procedure showBorrowHistoryUtil(username : string; ptrbook : pbook; ptrborrow : pborrow);
    {DESKRIPSI  : (F11) Menampilkan riwayat peminjaman dari username pada borrow.csv}
    {I.S.       : username bertipe string, ptrbook (pointer pada book.csv), dan ptruser (pointer pada borrow.csv)}
    {F.S.       : Menampilkan riwayat peminjaman ke layar}
    {Proses     : Menuliskan riwayat peminjaman dengan skema searching}

    {KAMUS LOKAL}
    var
        i, idx : integer;

    {ALGORITMA}
    begin
        {INISIASASI}
        i := 1;

        {SKEMA PENGULANGAN BERDASARKAN KONDISI BERHENTI}
        while (i <= borrowNeff) do begin
            if (username = ptrborrow^[i].username) then begin
                idx := checkLocation(ptrborrow^[i].id, ptrbook); {Pemanggilan fungsi mencari indeks dari id untuk menampilkan title}
                writeln(DateToStr(ptrborrow^[i].borrowDate), ' | ', ptrborrow^[i].id, ' | ', unwraptext(ptrbook^[idx].title));
            end;
            i += 1;
        end;
    end;

procedure showStatsUtil(ptrbook : pbook; ptruser : puser);
    {DESKRIPSI  : (F12) Menampilkan data statistik berupa admin, pengunjung, dan 5 jenis buku berdasarkan user.csv dan book.csv}
    {I.S        : ptrbook valid (pointer pada book.csv), dan ptruser valid (pointer pada user.csv)}
    {F.S        : Menampilkan jenis-jenis statistik di layar }
    {Proses     : Menulis jenis-jenis statistik ke layar berdasarkan book.csv}

    {KAMUS LOKAL}
    var
        total : integer;

    {ALGORITMA}
    begin
        writeln('Pengguna:');
        writeln('Admin | ',         countAdmin(ptruser));
        writeln('Pengunjung | ',    countPengunjung(ptruser));
        writeln('Total | ',         countAdmin(ptruser) + countPengunjung(ptruser));
		writeln();
		
        total := 0;
        writeln('Buku:');
        writeln('sastra | ',      countBuku('sastra', ptrbook)      ); total += countBuku('sastra', ptrbook);
        writeln('sains | ',       countBuku('sains', ptrbook)       ); total += countBuku('sains', ptrbook);
        writeln('manga | ',       countBuku('manga', ptrbook)       ); total += countBuku('manga', ptrbook);
        writeln('sejarah | ',     countBuku('sejarah', ptrbook)     ); total += countBuku('sejarah', ptrbook);
        writeln('programming | ', countBuku('programming', ptrbook) ); total += countBuku('programming', ptrbook);
        writeln('Total | ', total);
    end;

end. 
