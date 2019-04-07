unit F03;
{DESKRIPSI}
{REFERENSI}

interface
uses
	ubook;

{PUBLIC, VARIABLE, CONST, ADT}
{ - }

{PUBLIC, FUNCTION, PROCEDURE}
procedure findbookbyyear(ptrbook: pbook);

	
implementation
{PRIVATE VARIABLE, CONST, ADT}
{ - }

{FUNGSI dan PROSEDUR}
function kategoriValid(q : string): boolean;
	{DESKRIPSI	: mengecek apakah query yang dimasukkan user valid/tidak}
	{PARAMETER	: kategori input user }
	{RETURN 	: boolean apakah kategori valid }

	{KAMUS LOKAL}
	const
		categories : array [1..5] of string = ('programming',
											 'sains',
											 'sejarah',
											 'manga',
											 'sastra');

	var
		str : string;

	{ALGORITMA}
	begin
		for str in categories do begin
			if q = str then begin
				exit(true);
			end;
		end;
		kategoriValid := false;
	end;

procedure sort (ptrarraybuku: pbook; counter: integer);
	{
	* DESKRIPSI	: 
	* PARAMETER	: 
	* RETURN	: 
	}

	{KAMUS LOKAL}
	var
		i, j		: integer;
		tmp 		: book;

	{ALGORITMA}
	begin	
		for j := 1 to counter-1 do begin
			for i := j to counter-1 do begin
				if ptrarraybuku^[i].title > ptrarraybuku^[i+1].title then begin
					{Tukar arraybuku indeks ke-i dengan i+1}
					tmp 				:= ptrarraybuku^[i];
					ptrarraybuku^[i] 	:= ptrarraybuku^[i+1];
					ptrarraybuku^[i+1] 	:= tmp;
				end;
			end;
		end;
	end;


procedure findbookbyyear(ptrbook: pbook);
	{
	* DESKRIPSI	: 
	* PARAMETER	: 
	* RETURN	: 
	}

	{KAMUS LOKAL}
	var
		buku 			: book;
		i, counter 		: integer;
		Found 			: boolean;
		arraybuku 		: tbook;
		ptrarraybuku 	: pbook;

	{ALGORITMA}
	begin
		write('Masukkan kategori:');
		readln(buku.category);
		
		if kategoriValid(buku.category) then begin
			Found := false;
			i := 1;
			counter := 0;
			while (i <= bookNeff) do begin
				if (buku.category = ptrbook^[i].category) then begin
					Found := true;
					counter := counter + 1;
					arraybuku [counter] := ptrbook^[i];
				end;
				i += 1
			end; { i > userNeff or Found }
			
			writeln('ada', counter);
			if Found then begin
				new(ptrarraybuku);
				ptrarraybuku^ := arraybuku;
				sort (ptrarraybuku, counter);
				
				for i := 1 to counter do begin
					writeln(ptrarraybuku^[i].id, ' | ' , ptrarraybuku^[i].title , ' | ' , ptrarraybuku^[i].author);
				end;

			end else begin
				writeln ('Tidak ada buku dalam kategoti ini.');
			end;

		end else begin
			writeln ('Kategori ', buku.category ,' tidak valid.');
		end;
	end;
end.
