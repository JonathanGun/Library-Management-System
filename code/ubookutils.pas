unit ubookutils;
{Berisi fungsi perantara untuk unit buku seperti menghitung jumlah buku, mencari indeks buku di array, dll}
{REFERENSI : - }

interface
{PUBLIC VARIABLE, CONST, ADT}
uses
	ubook, uuser, udate;

{PUBLIC, FUNCTION, PROCEDURE}
function countAdmin(ptruser : puser):integer;
function countPengunjung(ptruser : puser):integer;
function countBuku(category : string; ptrbook : pbook):integer;

function checkLocation (id : integer; ptr : pbook):integer;
function searchBorrow(id : integer; username: string; ptrborrow: pborrow): BorrowHistory;

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
	{DESKRIPSI	: }
	{I.S		: }
	{F.S		: }
	{Proses		: }

	{KAMUS LOKAL}
    var
        found   : boolean;
        i       : integer;

	{ALGORITMA}
	begin
        {SKEMA SEARCHING DENGAN BOOLEAN}
        found := false;
        i := 1;
        while (not found) and (i <= borrowNeff) do begin
            if (ptrborrow^[i].username = username) and (ptrborrow^[i].id = id) then begin
                searchBorrow := ptrborrow^[i];
                ptrborrow^[i].isBorrowed := false;
                found := true;
            end;
            i += 1;
        end;

        if (not found) then begin
            writeln('Anda tidak sedang meminjam buku tersebut');
            searchBorrow.username := 'Anonymous';
        end;
	end;

end.
