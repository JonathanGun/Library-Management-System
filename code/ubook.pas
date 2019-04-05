unit ubook;
{Mengatur ADT Buku, pencarian buku, peminjaman dan pengembalian buku, d fungsi2 lain berhubungan dengan buku}
{REFERENSI : - }

interface
{PUBLIC VARIABLE, CONST, ADT}
uses
	udate;

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
{ - }

implementation
{PRIVATE VARIABLE, CONST, ADT}
{ - }

{FUNGSI dan PROSEDUR}
{ - }

end.
