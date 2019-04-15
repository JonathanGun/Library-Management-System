unit ubooksearch;
{Berisi fungsi (F03, F04) untuk mencari buku di perpustakaan}
{REFERENSI}

interface
uses
	ucsvwrapper,
	ubook, ubookutils;

{PUBLIC, FUNCTION, PROCEDURE}
function categoryValid(q : string): boolean;
procedure findBookByCategoryUtil(category: string; ptrbook:pbook); {F03}
procedure findBookByYearUtil(year:integer; category:string; ptrbook:pbook); {F04}
	
implementation
{FUNGSI dan PROSEDUR}
function fitCategory(year:integer; category:string; currentyear:integer) : boolean;
	{DESKRIPSI	: menjelaskan fungsi fitcategory}
	{PARAMETER	: menjelaskan masing-masing parameter}
	{RETURN	: apakah dia fitcategory atau tidak}

	{KAMUS LOKAL}
	{-}

	{ALGORITMA}
	begin
		if (category = '<') then begin
			fitcategory := currentyear < year;
		end else if (category = '=') then begin
			fitcategory := currentyear = year;
		end else if (category = '>') then begin
			fitcategory := currentyear > year;
		end else if (category = '<=') then begin
			fitcategory := currentyear <= year;
		end else if (category = '>=') then begin
			fitcategory := currentyear >= year;
		end;
	end;

function categoryValid(q : string): boolean;
	{DESKRIPSI	: mengecek apakah query yang dimasukkan user valid/tidak}
	{PARAMETER	: kategori input user }
	{RETURN 	: boolean apakah kategori valid }

	{KAMUS LOKAL}
	var
		str : string;
		i 	: integer;

	{ALGORITMA}
	begin
		categoryValid := false;
		for i := 1 to NUMCATEGORIES do begin
			str := CATEGORIES[i];
			if (q = str) then begin
				categoryValid := true;
			end;
		end;
	end;

procedure sortBookByTitle(ptr: pbook; counter: integer);
	{DESKRIPSI	: }
	{PARAMETER	: }
	{RETURN	: }

	{KAMUS LOKAL}
	var
		i, j		: integer;
		tmp 		: book;

	{ALGORITMA}
	begin
		{bubble sort}
		for j := 1 to counter-1 do begin
			for i := j to counter-1 do begin
				if ptr^[i].title > ptr^[i+1].title then begin
					{Tukar arraybuku indeks ke-i dengan i+1}
					tmp 				:= ptr^[i];
					ptr^[i] 	:= ptr^[i+1];
					ptr^[i+1] 	:= tmp;
				end;
			end;
		end;
	end;


procedure findBookByCategoryUtil(category: string; ptrbook:pbook);
	{DESKRIPSI	: (F03)}
	{PARAMETER	: }
	{RETURN	: }

	{KAMUS LOKAL}
	var
		i, counter 		: integer;
		found 			: boolean;
		filteredBooks 	: tbook;
		ptr 			: pbook;

	{ALGORITMA}
	begin
		if (categoryValid(category)) then begin
			i := 1;
			counter := 0;

			{skema pencarian dengan boolean}
			found := false;
			while (i <= bookNeff) do begin
				if (category = ptrbook^[i].category) then begin
					found := true;
					counter += 1;
					filteredBooks[counter] := ptrbook^[i];
				end;
				i += 1
			end; { i > userNeff or found }
			
			if (found) then begin
				new(ptr);
				ptr^ := filteredBooks;
				sortBookByTitle(ptr, counter);
				
				for i := 1 to counter do begin
					writeln(ptr^[i].id, ' | ' , unwraptext(ptr^[i].title) , ' | ' , unwraptext(ptr^[i].author));
				end;

			end else begin
				writeln ('Tidak ada buku dalam kategori ini.');
			end;

		end else begin
			writeln ('Kategori ', category ,' tidak valid.');
		end;
	end;

procedure findBookByYearUtil(year:integer; category:string; ptrbook:pbook);
	{DESKRIPSI	: (F04)}
	{I.S.		: }
	{F.S.		: }
	{Proses	: }

	{KAMUS LOKAL}
	var
		i, counter 		: integer;
		found 			: boolean;
		filteredBooks 	: tbook;
		ptr 			: pbook;
		
	{ALGORITMA}
	begin
		writeln('Buku yang terbit pada tahun ', category, ' ', year, ':');

		{skema pencarian dengan boolean}
		i := 1;
		counter := 0;
		found := false;
		while (i <= bookNeff) do begin
			if (fitcategory(year, category, ptrbook^[i].year))  then begin
				found := true;
				counter += 1;
				filteredBooks[counter] := ptrbook^[i];
			end;
			i += 1
		end;

		if (found) then begin
			new(ptr);
			ptr^ := filteredBooks;
			sortBookByTitle(ptr, counter);

			for i := 1 to counter do begin
				writeln(ptr^[i].id, '|', unwraptext(ptr^[i].title), '|', unwraptext(ptr^[i].author));
				found := true;
			end;

		end else begin
			writeln('Tidak ada buku yang sesuai');
		end;
	end;
end.
