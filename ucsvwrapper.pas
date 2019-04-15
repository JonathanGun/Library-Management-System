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
{FUNGSI dan PROSEDUR}
function wraptext(str: string): string;
	{DESKRIPSI	: Membungkus string agar dapat memuat karakter koma (',')}
	{PARAMETER 	: string yang ingin dibungkus(wrapped)}
	{RETURN 	: string yang sudah terbungkus(wrapped)}

	{KAMUS LOKAL}
	var
		i : integer;

	{ALGORITMA}
	begin
		{Diawali dan diakhiri dengan quote ' " ', serta mengubah semua quote menjadi double quote ' "" '}
		wraptext := '"';
		for i := 1 to length(str) do begin
			if (str[i] = wrapper) then begin
				wraptext += wrapper + wrapper;
			end else begin
				wraptext += str[i];
			end;
		end;
		wraptext += '"';
	end;

function unwraptext(str: string): string;
	{DESKRIPSI	: Kebalikan dari wraptext, mengembalikan ke string semulanya}
	{PARAMETER 	: string yang ingin dikembalikan seperti semula}
	{RETURN 	: string yang sudah dikembalikan seperti semula}

	{KAMUS LOKAL}
	var
		i : integer;

	{ALGORITMA}
	begin
		unwraptext := '';
		{mengabaikan karakter pertama dan terakhir, yaitu quote ' " '}
		i := 2;
		while (i <= length(str) - 1) do begin
			unwraptext += str[i];
			if (str[i] = wrapper) then begin
				i += 1;
			end;
			i += 1;
		end;
	end;

end.