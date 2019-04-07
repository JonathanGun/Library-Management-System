Unit F01;

interface
uses
	uuser;

procedure userregistration (pengunjung : user; ptruser: puser);
	
implementation
procedure userregistration (pengunjung : user; ptruser: puser);
begin
	ptruser^[userNeff + 1].fullname := pengunjung.fullname;
	ptruser^[userNeff + 1].address := pengunjung.address;
	ptruser^[userNeff + 1].username := pengunjung.username;
	ptruser^[userNeff + 1].password := pengunjung.password;
	userNeff += 1;
end;
end.
