unit ubook;
{Unit mengatur ADT Buku, pointernya, arraynya, dll}
{REFERENSI : - }

interface
uses
	udate, uuser;

{PUBLIC VARIABLE, CONST, ADT}
const
	BOOK_MAX 		= 1000;
	BORROW_MAX 		= 1000;
	RETURN_MAX 		= 1000;
	MISSING_MAX 	= 1000;

	BOOK_COLUMN 	= 6;
	BORROW_COLUMN	= 5;
	RETURN_COLUMN	= 3;
	MISSING_COLUMN	= 3;

	NUMCATEGORIES	= 5;
	CATEGORIES : array [1..NUMCATEGORIES] of string =
	('programming', 'sains', 'sejarah', 'manga', 'sastra');

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
		username 	: string;
		id 			: integer;
		borrowDate	: Date;
		returnDate	: Date;
		isBorrowed	: boolean;
	end;

	ReturnHistory = record
		username	: string;
		id			: integer;
		returnDate	: Date;
	end;

	MissingBook = record
		username	: string;
		id 			: integer;
		reportDate	: Date;
	end;

	{Definisi ADT array of X dan pointernya}
	{Agar dapat digunakan di program utama dan unit lain}
	tbook 	= array [1..BOOK_MAX] of Book;
	pbook 	= ^tbook;

	tborrow = array [1..BORROW_MAX] of BorrowHistory;
	pborrow = ^tborrow;

	tmissing= array [1..MISSING_MAX] of MissingBook;
	pmissing= ^tmissing;

	treturn = array [1..RETURN_MAX] of ReturnHistory;
	preturn = ^treturn;

	psinglebook 	= ^Book;
	psingleborrow 	= ^BorrowHistory;
	psinglemissing 	= ^MissingBook;
	psinglereturn 	= ^ReturnHistory;


var
	{N efektif, jumlah array yang terisi}
	bookNeff : Integer;
	borrowNeff: integer;
	returnNeff: integer;
	missingNeff: integer;
	
implementation

end.
