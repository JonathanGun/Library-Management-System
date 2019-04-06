unit ubook;
{Mengatur ADT Buku, pencarian buku, peminjaman dan pengembalian buku, dan fungsi-fungsi lain berhubungan dengan buku}
{FUNGSI-FUNGSI YANG TERKAIT :
* F10 - Melakukan penambahan jumlah buku ke sistem
* F11 - Melihat riwayat peminjaman
* F12 - Statistik }
{REFERENSI : - }

interface
{PUBLIC VARIABLE, CONST, ADT}
uses
	udate, uuser;
const
	BOOK_MAX 	= 1000;
	BOOK_COLUMN = 6;

	BORROW_MAX 		= 1000;
	BORROW_COLUMN	= 5;

	RETURN_MAX 		= 1000;
	RETURN_COLUMN	= 3;

	MISSING_MAX 	= 1000;
	MISSING_COLUMN	= 3;

type
	{Definisi ADT Buku, dll}
	Book = record
		id			: integer;
		title		: string;
		author		: string;
		qty			: integer;
		year		: integer;
		category	: string;
	end;

	BorrowHistory = record
		username 	: string; {User.username}
		id 			: integer; {Book.id}
		borrowDate	: Date;
		returnDate	: Date;
		isBorrowed	: boolean;
	end;

	ReturnHistory = record
		username	: string; {User.username}
		id			: integer; {Book.id}
		returnDate	: Date;
	end;

	MissingBook = record
		username	: string; {User.username}
		id 			: integer;
		reportDate	: Date;
	end;

	{Definisi ADT array of X dan pointernya}
	{Agar dapat digunakan di program utama dan unit lain}
	tbook = array [1..BOOK_MAX] of Book;
	pbook = ^tbook;

	tborrow = array [1..BORROW_MAX] of BorrowHistory;
	pborrow = ^tborrow;

	tmissing= array [1..MISSING_MAX] of MissingBook;
	pmissing= ^tmissing;

	treturn = array [1..RETURN_MAX] of ReturnHistory;
	preturn = ^treturn;


var
	{N efektif, jumlah array yang terisi}
	bookNeff : Integer;
	borrowNeff: integer;
	returnNeff: integer;
	missingNeff: integer;


{PUBLIC FUNCTIONS, PROCEDURE}
{FUNGSI-FUNGSI PENUNJANG}
function CountingAdmin(ptruser : puser):integer;
function CountingPengunjung(ptruser : puser):integer;
function CountingBuku(category : string; ptrbook : pbook):integer;
function checkLocation (id : integer; ptr : pbook):integer;

{FUNGSI-FUNGSI UTAMA F07, F08, dan F09}
procedure tambah_buku (ptrbook : pbook);

{FUNGSI-FUNGSI UTAMA F10, F11, dan F12}
procedure Stats(ptrbook : pbook; ptruser : puser);
procedure Add_book_qty (id,qty : integer; ptr : pbook);
procedure Borrow_history (username : string; ptrbook : pbook; ptruser : pborrow);


implementation

{FUNGSI dan PROSEDUR}
procedure tambah_buku (ptrbook : pbook);
begin
	writeln('$ tambah_buku');
	bookNeff := bookNeff + 1;
	writeln('Masukkan Informasi buku yang ditambahkan:');
	write('Masukkan id buku: ');
	readln(ptrbook^[bookNeff].id);
	write('Masukkan judul buku: ');
	readln(ptrbook^[bookNeff].title);
	write('Masukkan pengarang buku: ');
	readln(ptrbook^[bookNeff].author);
	write('Masukkan jumlah_buku: ');
	readln(ptrbook^[bookNeff].qty);
	write('Masukkan tahun terbit buku: ');
	readln(ptrbook^[bookNeff].year);
	write('Masukkan kategori buku: ');
	readln(ptrbook^[bookNeff].category);
	writeln();
	writeln('Buku berhasil ditambahkan ke dalam sistem!');
end;

function CountingAdmin(ptruser : puser):integer;
	{DESKRIPSI	: Menghitung banyak admin dalam data user.csv}
	{PARAMETER	: Ptruser (pointer pada user.csv)}
	{RETURN		: sebuah bilangan integer}

{KAMUS LOKAL}
var i,sum : integer;

{ALGORITMA}
begin
	{INISIALISASI}
	sum := 0;
	i := 1;
	{TAHAP PENCACAHAN}
	while (i <= userNeff) do
	begin
		if (ptruser^[i].isAdmin) then
			sum := sum + 1;
		i := i + 1;
	end;
	CountingAdmin := sum;
end;

function CountingPengunjung(ptruser : puser):integer;
	{DESKRIPSI	: Menghitung banyak pengunjung dalam data user.csv}
	{PARAMETER	: Ptruser (pointer pada user.csv)}
	{RETURN		: sebuah bilangan integer}

{KAMUS LOKAL}
var i,sum : integer;

{ALGORITMA}
begin
	{INISIALISASI}
	sum := 0;
	i := 1;
	{TAHAP PENCACAHAN}
	while (i <= userNeff) do
	begin
		if (ptruser^[i].isAdmin = False) then
			sum := sum + 1;
		i := i + 1;
	end;
	CountingPengunjung := sum;
end;

function CountingBuku(category : string; ptrbook : pbook):integer;
	{DESKRIPSI	: Menghitung banyak buku berdasarkan jenis buku dalam book.csv}
	{PARAMETER	: category bertype string dan Ptrbook (pointer pada book.csv)}
	{RETURN		: sebuah bilangan integer}

{KAMUS LOKAL}
var i,sum: integer;

{ALGORITMA}
begin
	{INISIALISASI}
	sum := 0;
	i := 1;
	{TAHAP PENCACAHAN}
	while (i <= bookNeff) do
	begin
		if (ptrbook^[i].category = category) then
			sum := sum + ptrbook^[i].qty;
		i := i + 1;
	end;
	CountingBuku := sum;
end;

function checkLocation (id : integer; ptr : pbook):integer;
	{DESKRIPSI	: Mencari lokasi keberadaan id dengan skema searching pada book.csv}
	{PARAMETER	: id bertipe integer dan Ptrbook (pointer pada book.csv)}
	{RETURN		: sebuah bilangan integer yang melambangkan indeks dari id}

{KAMUS LOKAL}
var i,idx : integer;
	found : boolean;

{ALGORITMA}
begin
	{INISIALISASI}
	found := False;
	i := 1;
	{TAHAP PENCARIAN}
	while not(found) and (i <= bookNeff) do
	begin
		if (id = ptr^[i].id) then
		begin
			idx := i;
			found := True;
		end;
		i := i + 1;
	end;
	checkLocation := idx;
end;

{F10 - Melakukan penambahan jumlah buku ke dalam sistem}
procedure Add_book_qty (id,qty : integer; ptr : pbook);
	{DESKRIPSI	: Menambahkan jumlah buku dengan skema searching pada id yang ingin ditambahkan pada book.csv}
	{PARAMETER	: id dan qty yang bertipe integer dan Ptrbook (pointer pada book.csv)}
	{RETURN		: - }

{KAMUS LOKAL}
var i,idx : integer;
	found : boolean;

{ALGORITMA}
begin
	{INISIALISASI}
	i := 1;
	found := False;
	{SKEMA SEARCHING}
	while not(found) and (i <= bookNeff) do
	begin
		if (id = ptr^[i].id) then
		begin
			idx := i;
			found := True;
		end;
		i := i + 1;
	end;
	{TAHAP PENAMBAHAN JUMLAH BUKU}
	ptr^[idx].qty += qty;
	writeln('Pembaharuan jumlah buku berhasil dilakukan, total buku ');
	write(ptr^[idx].title);
	write(' menjadi ');
	writeln(ptr^[idx].qty);
end;

{F11 - Melihat riwayat peminjaman}
procedure Borrow_history (username : string; ptrbook : pbook; ptruser : pborrow);
	{DESKRIPSI	: Menampilkan riwayat peminjaman dari username pada borrow.csv}
	{PARAMETER	: username bertipe string, ptrbook (pointer pada book.csv), dan ptruser (pointer pada borrow.csv)}
	{RETURN		: - }

{KAMUS LOKAL}
var i,idx : integer;

{ALGORITMA}
begin
	{INISIALISASI}
	i := 1;
	{SKEMA PENGULANGAN BERDASARKAN KONDISI BERHENTI}
	while (i <= bookNeff) do
	begin
		if (username = ptruser^[i].username) then
		begin
			idx := checkLocation(ptruser^[i].id,ptrbook); {Pemanggilan fungsi mencari indeks dari id untuk menampilkan title}
			write(ptruser^[i].borrowDate.day,'/',ptruser^[i].borrowDate.month,'/',ptruser^[i].borrowDate.year);
			writeln(' | ',ptruser^[i].id,' | ',ptrbook^[idx].title);
		end;
		i := i + 1;
	end;
end;

{F12 - Statistik}
procedure Stats(ptrbook : pbook; ptruser : puser);
	{DESKRIPSI	: Menampilkan data statistik berupa admin, pengunjung, dan 5 jenis buku berdasarkan user.csv dan book.csv}
	{PARAMETER	: ptrbook (pointer pada book.csv), dan ptruser (pointer pada user.csv)}
	{RETURN		: - }

{KAMUS LOKAL}
var total : integer;

{ALGORITMA}
begin
	writeln('Pengguna:');
	write('Admin | ');
	writeln(CountingAdmin(ptruser));
	write('Pengunjung | ');
	writeln(CountingPengunjung(ptruser));
	write('Total | ');
	writeln(CountingAdmin(ptruser)+CountingPengunjung(ptruser));
	total := 0;
	write('Buku:');
	write('sastra | ');
	writeln(CountingBuku('sastra',ptrbook));
	total := total + CountingBuku('sastra',ptrbook);
	write('sains | ');
	writeln(CountingBuku('sains',ptrbook));
	total := total + CountingBuku('sains',ptrbook);
	write('manga | ');
	writeln(CountingBuku('manga',ptrbook));
	total := total + CountingBuku('manga',ptrbook);
	write('sejarah | ');
	writeln(CountingBuku('sejarah',ptrbook));
	total := total + CountingBuku('sejarah',ptrbook);
	write('programming | ');
	writeln(CountingBuku('programming',ptrbook));
	total := total + CountingBuku('programming',ptrbook);
	write('Total | ');
	writeln(total);
end;

end.
