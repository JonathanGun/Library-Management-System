unit ucsvwrapper;
{Membungkus teks agar kompatibel dengan csv dan dapat memuat koma di dalamnya}
{REFERENSI : https://stackoverflow.com/questions/4617935/is-there-a-way-to-include-commas-in-csv-columns-without-breaking-the-formatting}

interface
{PUBLIC VARIABLE, CONST, ADT}
const
	wrapper = '"';
	
{PUBLIC FUNCTIONS, PROCEDURE}
function wraptext(str: string): string;
function unwraptext(str: string): string;

implementation
{Realisasi FUNGSI dan PROSEDUR}
function wraptext(str: string): string;
	{DESKRIPSI	: }
	{PARAMETER 	: }
	{RETURN 	: }

	{KAMUS LOKAL}
	var
		i : integer;

	{ALGORITMA}
	begin
		wraptext := '"';
		for i := 1 to length(str) do begin
			if (str[i] = '"') then begin
				wraptext += '""';
			end else begin
				wraptext += str[i];
			end;
		end;
		wraptext += '"';
	end;

function unwraptext(str: string): string;
	{DESKRIPSI	: }
	{PARAMETER 	: }
	{RETURN 	: }

	{KAMUS LOKAL}
	var
		i : integer;

	{ALGORITMA}
	begin
		unwraptext := '';
		i := 2;
		while (i <= length(str) - 1) do begin
			unwraptext += str[i];
			if (str[i] = '"') then begin
				i += 1;
			end;
			i += 1;
		end;
	end;

end.