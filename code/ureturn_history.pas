unit ureturn_history;

interface
uses udate;

{PUBLIC VARIABLE, CONST, ADT}
const
	RETURN_MAX 		= 1000;
	RETURN_COLUMN	= 3;

type
	{Definisi ADT ReturnHistory}
	ReturnHistory = record
		username	: string; {User.username}
		id		: integer; {Book.id}
		returnDate	: Date;
	end;

	{Definisi ADT array of ReturnHistory dan pointernya}
	{Agar dapat digunakan di program utama dan unit lain}
	treturn = array [1..RETURN_MAX] of ReturnHistory;
	preturn = ^treturn;

var
	returnNeff: integer;

{PUBLIC FUNCTIONS, PROCEDURE}
{ - }

implementation
{PRIVATE VARIABLE, CONST, ADT}
{ - }

{FUNGSI dan PROSEDUR}
{ - }

end.
