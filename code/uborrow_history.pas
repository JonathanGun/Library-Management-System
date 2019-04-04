unit uborrow_history;

interface
uses udate;

{PUBLIC VARIABLE, CONST, ADT}
const
	BORROW_MAX 		= 1000;
	BORROW_COLUMN	= 5;

type
	{Definisi ADT BorrowHistory}
	BorrowHistory = record
		username 	: string; {User.username}
		id 			: integer; {Book.id}
		borrowDate	: Date;
		returnDate	: Date;
		isBorrowed	: boolean;
	end;

	{Definisi ADT array of BorrowHistory dan pointernya}
	{Agar dapat digunakan di program utama dan unit lain}
	tborrow = array [1..BORROW_MAX] of BorrowHistory;
	pborrow = ^tborrow;

var
	borrowNeff: integer;

{PUBLIC FUNCTIONS, PROCEDURE}
{ - }

implementation
{PRIVATE VARIABLE, CONST, ADT}
{ - }

{FUNGSI dan PROSEDUR}
{ - }

end.
