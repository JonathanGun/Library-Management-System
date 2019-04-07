unit F04;
{DESKRIPSI}
{REFERENSI}

interface
uses ubook;
{PUBLIC, VARIABLE, CONST, ADT}
{-}

{PUBLIC, FUNCTION, PROCEDURE}
function fitcategory(year:integer; category:string; currentyear:integer) : boolean;
procedure findbook(year:integer; category:string; ptrbook:pbook);

implementation
{PRIVATE VARIABLE, CONST, ADT}
{-}

{FUNGSI dan PROSEDUR}
function fitcategory(year:integer; category:string; currentyear:integer) : boolean;
{
* DESKRIPSI	: menjelaskan fungsi fitcategory
* PARAMETER	: menjelaskan masing-masing parameter
* RETURN	: apakah dia fitcategory atau tidak
}

{KAMUS LOKAL}
{-}

{ALGORITMA}
begin
if category = '<' then
	begin
	fitcategory := currentyear < year;
	end else
	if category = '=' then
		begin
		fitcategory := currentyear = year;
		end else
		if category = '>' then
			begin
			fitcategory := currentyear > year;
			end else
			if category = '<=' then
				begin
				fitcategory := currentyear <= year;
				end else
				if category = '>=' then
					begin
					fitcategory := currentyear >= year;
					end;
end;

procedure findbook(year:integer; category:string; ptrbook:pbook);
{
* DESKRIPSI	:
* I.S.		:
* F.S.		:
* Proses	:
}

{KAMUS LOKAL}
var
	found : boolean;
	i	  : integer;
	
{ALGORITMA}
begin
writeln('Buku yang terbit', category, year);
found := false;

for i := 1 to bookNeff do
	begin
	if fitcategory(year, category, ptrbook^[i].year) then
		begin
		writeln(ptrbook^[i].id, '|', ptrbook^[i].title, '|', ptrbook^[i].author);
		found := true;
		end;
	end;
if not found then
	begin
	writeln('Tidak ada buku yang sesuai');
	end;
end;
end.
