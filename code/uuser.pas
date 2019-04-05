unit uuser;

interface
{PUBLIC VARIABLE, CONST, ADT}
const
	USER_MAX 	= 1000;
	USER_COLUMN	= 5;

type
	{Definisi ADT User}
	User = record
		fullname	: string;
		address		: string;
		username	: string;
		password	: string;
		isAdmin		: boolean;
	end;

	{Definisi ADT array of User dan pointernya}
	{Agar dapat digunakan di program utama dan unit lain}
	tuser = array [1..USER_MAX] of User;
	puser = ^tuser;

var
	userNeff: integer;

{PUBLIC FUNCTIONS, PROCEDURE}
{ - }

implementation
{PRIVATE VARIABLE, CONST, ADT}
{ - }

{FUNGSI dan PROSEDUR}
{ - }

end.
