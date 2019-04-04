unit ubook;

interface
{PUBLIC VARIABLE, CONST, ADT}
const
	BOOK_MAX 	= 1000;
	BOOK_COLUMN = 6;

type
	{Definisi ADT User}
	Book = record
		id			: integer;
		title		: string;
		author		: string;
		qty			: integer;
		year		: integer;
		category	: string;
	end;

	{Definisi ADT array of Book dan pointernya}
	{Agar dapat digunakan di program utama dan unit lain}
	tbook = array [1..BOOK_MAX] of Book;
	pbook = ^tbook;

var
	bookNeff : Integer;

{PUBLIC FUNCTIONS, PROCEDURE}
{ - }

implementation
{PRIVATE VARIABLE, CONST, ADT}
{ - }

{FUNGSI dan PROSEDUR}
{ - }

end.
