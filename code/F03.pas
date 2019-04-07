Unit F03;

interface
uses
	ubook;
var
	buku : book;
	arraybuku : tbook;
	ptrarraybuku : pbook;

procedure findbook (ptrbook: pbook);

	
implementation
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
var
	i,j: integer;
	tampungbentar : book;

begin	
for j := 1 to counter do
begin
	for i := j to counter do 
	begin
		if ptrarraybuku^[i].title > ptrarraybuku^[i+1].title then
		begin
			tampungbentar := ptrarraybuku^[i];
			ptrarraybuku^[i] := ptrarraybuku^[i+1];
			ptrarraybuku^[i+1] := tampungbentar;
		end;
	end;
end;
end;


procedure findbook (ptrbook: pbook);
var
	buku : book;
	i, counter : integer;
	Found : boolean;

begin
	writeln ('Masukkan kategori:');
	readln (buku.category);
	
	if kategoriValid(buku.category) then
	begin
	Found := false;
	i := 1;
	counter := 0;
		while (i <= bookNeff) do
		begin
			if (buku.category = ptrbook^[i].category) then
				begin
				Found := true;
				counter := counter + 1;
				arraybuku [counter] := ptrbook^[i];
				i := i + 1;
			end else begin
				i := i+ 1;
			end;
		end; { i > userNeff or Found }
		
		if (Found) then
		begin
			new(ptrarraybuku);
			ptrarraybuku^ := arraybuku;
			sort (ptrarraybuku, counter-1);
			writeln('ada', counter, 'buku',buku.category);
			
			for i := 1 to counter do
			begin
				writeln(ptrarraybuku^[i].id, ' | ' , ptrarraybuku^[i].title , ' | ' , ptrarraybuku^[i].author);
			end;
		end else
		begin
			writeln ('Tidak ada buku dalam kategoti ini.');
		end;
	end else begin
		writeln ('Kategori ', buku.category ,' tidak valid.');
	end;
	
end;
end.
