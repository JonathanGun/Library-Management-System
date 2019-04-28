unit ubookutils;
{Berisi fungsi perantara untuk unit buku seperti menghitung jumlah buku, mencari indeks buku di array, dll}
{REFERENSI : - }

interface
{PUBLIC VARIABLE, CONST, ADT}
uses
    ucsvwrapper,
	ubook, uuser, udate;

{PUBLIC FUNCTION, PROCEDURE}
function countAdmin(ptruser : puser):integer;
function countPengunjung(ptruser : puser):integer;
function countBuku(category : string; ptrbook : pbook):integer;

function checkLocation(id : integer; ptr : pbook):integer;
function searchBorrow(id : integer; username: string; ptrborrow: pborrow): BorrowHistory;
procedure sortBookByTitle(ptr: pbook; counter: integer);

implementation
{FUNGSI dan PROSEDUR}
function countAdmin(ptruser : puser): integer;
    {DESKRIPSI  : Menghitung banyak admin dalam data user.csv}
    {PARAMETER  : Ptruser (pointer pada user.csv)}
    {RETURN     : sebuah bilangan integer}
    
    {KAMUS LOKAL}
    var
        i  : integer;

    {ALGORITMA}
    begin
        {INISIASI}
        countAdmin := 0;
        i := 1;

        {TAHAP PENCACAHAN}
        while (i <= userNeff) do begin
            if (ptruser^[i].isAdmin) then begin
                countAdmin += 1;
            end;
            i += 1;
        end;
    end;

function countPengunjung(ptruser : puser): integer;
    {DESKRIPSI  : Menghitung banyak pengunjung dalam data user.csv}
    {PARAMETER  : Ptruser (pointer pada user.csv)}
    {RETURN     : sebuah bilangan integer}

    {KAMUS LOKAL}   
    var
        i : integer;

    {ALGORITMA}
    begin
        {INISIASI}
        countPengunjung := 0;
        i := 1;

        {TAHAP PENCACAHAN}
        while (i <= userNeff) do begin
            if (ptruser^[i].isAdmin = False) then begin
                countPengunjung += 1;
            end;
            i += 1;
        end;
    end;

function countBuku(category : string; ptrbook : pbook):integer;
    {DESKRIPSI  : Menghitung banyak buku berdasarkan jenis buku dalam book.csv}
    {PARAMETER  : category bertype string dan Ptrbook (pointer pada book.csv)}
    {RETURN     : sebuah bilangan integer}

    {KAMUS LOKAL}
    var
        i : integer;

    {ALGORITMA}
    begin
        {INISIALISASI}
        countBuku := 0;
        i := 1;

        {TAHAP PENCACAHAN}
        while (i <= bookNeff) do begin
            if (ptrbook^[i].category = category) then begin
                countBuku += ptrbook^[i].qty;
            end;
            i += 1;
        end;
    end;

function checkLocation(id : integer; ptr : pbook): integer;
	{DESKRIPSI	: Mencari lokasi keberadaan id dengan skema searching pada book.csv}
	{PARAMETER	: id bertipe integer dan Ptrbook (pointer pada book.csv)}
	{RETURN		: sebuah bilangan integer yang melambangkan indeks dari id}

	{KAMUS LOKAL}
	var
		i		: integer;
		found 	: boolean;
		
	{ALGORITMA}	
	begin
		{INISIALISASI}
		found := false;
		i := 1;

		{TAHAP PENCARIAN}
		while ((not found) and (i <= bookNeff)) do begin
			if (id = ptr^[i].id) then begin
				checkLocation := i;
				found := True;
			end;
			i += 1;
		end;
	end;

function searchBorrow(id : integer; username: string; ptrborrow: pborrow): BorrowHistory;
	{DESKRIPSI	: Mencari data peminjaman dengan id dan username tertentu}
    {PARAMETER  : id dan username yang ingin dicari pada array of history}
    {RETURN     : ADT borrowhistory dengan username dan id yang sesuai dengan parameter}

	{KAMUS LOKAL}
    var
        found   : boolean;
        i       : integer;

	{ALGORITMA}
	begin
        {SKEMA SEARCHING DENGAN BOOLEAN}
        found := false;
        i := 1;
        while ((not found) and (i <= borrowNeff)) do begin
            if (ptrborrow^[i].username = username) and (ptrborrow^[i].id = id) and (ptrborrow^[i].isBorrowed) then begin
                searchBorrow := ptrborrow^[i];
                ptrborrow^[i].isBorrowed := false;
                found := true;
            end;
            i += 1;
        end;

        if (not found) then begin
            writeln('Anda tidak sedang meminjam buku tersebut.');
            searchBorrow.username := wraptext('Anonymous');
        end;
	end;

procedure sortBookByTitle(ptr: pbook; counter: integer);
    {DESKRIPSI  : sortBookByTitle menyusun buku sesuai abjad pada judul buku}
    {I.S.       : array of Book terdefinisi}
    {F.S.       : buku tersusun sesuai abjad pada judul buku}
    {Proses     : dari array of book menyusun abjad pada judul buku dari A sampai Z dengan menggunakan bubble sort versi optimum}

    {KAMUS LOKAL}
    var
        i, pass     : integer;
        tmp         : book;
        tukar       : boolean;

    {ALGORITMA}
    begin
        {Skema Sorting dengan Optimized Bubble Sort}
        tukar   := true;
        pass    := 1;
        while ((pass <= counter-1) and tukar) do begin
            tukar := false;
            for i := 1 to (counter-pass) do begin
                if ptr^[i].title > ptr^[i+1].title then begin
                    {Tukar arraybuku indeks ke-i dengan i+1}
                    tmp         := ptr^[i];
                    ptr^[i]     := ptr^[i+1];
                    ptr^[i+1]   := tmp;

                    tukar       := true;
                end;
            end;
            pass += 1;
        end;
    end;

end.
