unit umissing_history;

interface
uses udate;

{PUBLIC VARIABLE, CONST, ADT}
const
	MISSING_MAX 	= 1000;
	MISSING_COLUMN	= 3;

type
	{Definisi ADT MissingBook}
	MissingBook = record
		username	: string; {User.username}
		id 			: integer;
		reportDate	: Date;
	end;

	{Definisi ADT array of MissingBook dan pointernya}
	{Agar dapat digunakan di program utama dan unit lain}
	tmissing= array [1..MISSING_MAX] of MissingBook;
	pmissing= ^tmissing;

var
	missingNeff: integer;
	
{PUBLIC FUNCTIONS, PROCEDURE}
{ - }

implementation
{PRIVATE VARIABLE, CONST, ADT}
{ - }

{FUNGSI dan PROSEDUR}
{ - }

end.