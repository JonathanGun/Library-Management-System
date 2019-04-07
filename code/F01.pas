unit F01;
{DESKRIPSI}
{REFERENSI}

interface
uses
	uuser;
{PUBLIC, VARIABLE, CONST, ADT}
{ - }

{PUBLIC, FUNCTION, PROCEDURE}
procedure userregistration (pengunjung : user; ptruser: puser);
	
implementation
{PRIVATE VARIABLE, CONST, ADT}
{ - }

{FUNGSI dan PROSEDUR}
procedure userregistration (pengunjung : user; ptruser: puser);
	{
	* DESKRIPSI	: 
	* PARAMETER	: 
	* RETURN	: 
	}

	{KAMUS LOKAL}
	begin
		ptruser^[userNeff + 1].fullname := pengunjung.fullname;
		ptruser^[userNeff + 1].address := pengunjung.address;
		ptruser^[userNeff + 1].username := pengunjung.username;
		ptruser^[userNeff + 1].password := pengunjung.password;
		userNeff += 1;
	end;
end.
