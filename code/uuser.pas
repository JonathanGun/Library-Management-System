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
function findUser(targetUsername : string; ptr: puser): User;

implementation
{PRIVATE VARIABLE, CONST, ADT}
{ - }

{FUNGSI dan PROSEDUR}
function findUser(targetUsername : string; ptr: puser): User;
	{DESKRIPSI	: mencari username yang sesuai dengan targetUsername}
	{PARAMETER	: string targetusername dan pointer dari array of user}
	{RETURN		: ADT User dengan username sesuai target}

	{KAMUS LOKAL}
	var
		sentinelUser 	: User;
		i 						: integer;
		found					: boolean;

	{ALGORITMA}
	begin
		{inisiasi username sentinel jika username tidak ditemukan di daftar}
		sentinelUser.fullname	:= 'Anonymous';
		sentinelUser.address	:= '';
		sentinelUser.username	:= 'Anonymous';
		sentinelUser.password	:= '12345678';
		sentinelUser.isAdmin	:= false;

		{skema pencarian sequential dengan boolean}
		found := false;
		i := 1;
		while (not found) and (i <= userNeff) do begin
			if ptr^[i].username = targetUsername then begin
				sentinelUser := ptr^[i];
				found := true;
			end;
			i += 1;
		end;

		findUser := sentinelUser;
	end;
end.
