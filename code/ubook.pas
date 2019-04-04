unit ubook;

interface

const
	MAXBOOK = 1000;
type
	Book = record
		id			: integer;
		title		: string;
		author		: string;
		qty			: integer;
		year		: integer;
		category	: string;
	end;

	tbook = array [1..MAXBOOK] of Book;
	pbook = ^tbook;

implementation

end.
