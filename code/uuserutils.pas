unit uuserutils;
{DESKRIPSI : Berisi fungsi (F01, F02, F15) yang berhubungan dengan tipe data user}
{REFERENSI : -}

interface
uses
	ucsvwrapper,
	uuser, k03_kel3_md5, crt;

{PUBLIC, FUNCTION, PROCEDURE}
procedure setToDefaultUser(ptr : psingleuser);
procedure registerUserUtil(pnewUser : psingleuser; ptruser: puser); {F01}
procedure loginUtil(ptr : psingleuser; ptruser: puser); {F02}
procedure findUserUtil(targetUsername : string; ptr: puser); {F15}

implementation
{FUNGSI dan PROSEDUR}
procedure setToDefaultUser(ptr : psingleuser);
	{DESKRIPSI	: Mengeset user target menjadi default - Anonymous}
	{PARAMETER	: user yang ingin diset menjadi default}
	{RETURN		: default User}

	{ALGORITMA}
	begin
		ptr^.fullname	:= wraptext('Anonymous');
		ptr^.address	:= wraptext('');
		ptr^.username	:= wraptext('Anonymous');
		ptr^.password	:= hashMD5('12345678');
		ptr^.isAdmin	:= false;
	end;

procedure registerUserUtil(pnewUser : psingleuser; ptruser: puser);
	{DESKRIPSI	: (F01) melakukan registrasi akun dari user dan admin}
	{I.S. 		: array of User terdefinisi}
	{F.S.		: keberhasilan registrasi ditampilkan di layar}
	{Proses 	: Menanyakan nama lengkap, alamat, username dan password user, dan layar menampilkan keberhasilan registrasi}
	
	{ALGORITMA}
	begin
		ptruser^[userNeff + 1] := pnewUser^;
		userNeff += 1;
		writeln('Pengunjung ', unwraptext(pnewUser^.fullname) , ' berhasil terdaftar sebagai user.');
	end;

procedure loginUtil(ptr : psingleuser; ptruser: puser);
	{DESKRIPSI	: (F02) melakukan login dari akun user yang telah dibuat}
	{I.S. 		: array of User terdefinisi}
	{F.S.		: berhasil atau gagalnya login}
	{Proses 	: User menginput username dan password, layar akan menampilkan keberhasilan login jika username dan password cocok
				  dengan yang sudah terdaftar}

	{KAMUS LOKAL}
	var
		found 	: boolean;
		i 		: integer;

	{ALGORITMA}
	begin
		{skema pencarian dengan boolean}
		found := false;
		i := 1;
		while ((i <= userNeff) and (not Found)) do begin
			if ((ptr^.username = ptruser^[i].username) and (ptr^.password = ptruser^[i].password)) then begin
				found := true;
				ptr^  := ptruser^[i];
			end;
			i += 1;
		end; { i > userNeff or Found }

		if (not found) then begin
			setToDefaultUser(ptr);
		end;

		clrscr;
		if (ptr^.username <> wraptext('Anonymous')) then begin
			writeln('Berhasil login.');
			writeln ('Selamat datang ', unwraptext(ptr^.fullname) , '!');
		end else begin
			writeln ('Username / password salah! Silakan coba lagi.');
		end;
	end;

procedure findUserUtil(targetUsername : string; ptr: puser);
	{DESKRIPSI	: (F15) Mencari username yang sesuai dengan targetUsername}
	{I.S. 		: array of User terdefinisi}
	{F.S.		: data nama dan alamat user sesuai dengan input tertampil di layar}
	{Proses 	: mencari user dengan username yang sesuai input pada array, lalu menampilkan datanya di layar}

	{KAMUS LOKAL}
	var
		i 			: integer;
		found		: boolean;

	{ALGORITMA}
	begin
		{skema pencarian sequential dengan boolean}
		found := false;
		i := 1;
		while ((not found) and (i <= userNeff)) do begin
			if (ptr^[i].username = targetUsername) then begin
				writeln('Nama Anggota   : ', unwraptext(ptr^[i].fullname));
				writeln('Alamat anggota : ', unwraptext(ptr^[i].address));
				found := true;
			end;
			i += 1;
		end;

		if (not found) then begin
			writeln('User dengan username ', unwraptext(targetUsername), ' tidak ditemukan.')
		end;			
	end;

end.
