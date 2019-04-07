Unit F02;

interface
uses
	uuser;

function loginuser (pengunjung : user; ptruser: puser): user;

implementation
function loginuser (pengunjung : user; ptruser: puser): user;
var
	Found 	: boolean;
	i 		: integer;
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
