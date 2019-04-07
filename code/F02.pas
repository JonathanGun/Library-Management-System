unit F02;
{DESKRIPSI}
{REFERENSI}

interface
uses
	uuser;
{PUBLIC, VARIABLE, CONST, ADT}
{ - }

{PUBLIC, FUNCTION, PROCEDURE}
function loginuser (pengunjung : user; ptruser: puser): user;

implementation
{PRIVATE VARIABLE, CONST, ADT}
{ - }

{FUNGSI dan PROSEDUR}
function loginuser (pengunjung : user; ptruser: puser): user;
	{
	* DESKRIPSI	: 
	* PARAMETER	: 
	* RETURN	: 
	}

	{KAMUS LOKAL}
	var
		Found 	: boolean;
		i 		: integer;

	{ALGORITMA}
	begin
		Found := false; { awal pencarian, belum ketemu }
		i := 1;
		while (i <= userNeff) and (not(Found)) do
		begin
			if (pengunjung.username = ptruser^[i].username) and (pengunjung.address = ptruser^[i].password) then begin
				Found := true;
				pengunjung := ptruser^[i];
			end else begin
				i := i + 1;
			end;
		end; { i > userNeff or Found }
		if not (Found) then begin
			pengunjung.username := 'Anonymous';
			pengunjung.password	:= '12345678';
			pengunjung.fullname	:= 'Anonymous';
			pengunjung.address	:= '';
			pengunjung.isAdmin	:= false;
		end;
		loginuser := pengunjung;
	end;
end.
