unit udate;
{Mengatur format tanggal dan konversinya dari string menjadi integer dan ADT Date}
{REFERENSI : https://www.freepascal.org/docs-html/rtl/sysutils/format.html
			 http://forum.lazarus.freepascal.org/index.php?topic=27778.0 (Topic: What is the format string for padding a number with leading zeros?)}

interface
uses sysutils;

{PUBLIC VARIABLE, CONST, ADT}
{ - }

type
	{Definisi ADT Date}
	Date = record
		day			: integer;
		month		: integer;
		year		: integer;
	end;

{PUBLIC FUNCTIONS, PROCEDURE}
function StrToDate_(rawDate: string): Date;
function DateToStr_(convertedDate: Date): string;

implementation
{PRIVATE VARIABLE, CONST, ADT}
{ - }

{FUNGSI dan PROSEDUR}
function StrToDate_(rawDate: string): Date;
	{DESKRIPSI	: Mengubah format masukan tanggal dari fromat string ke format ADT Date}
	{PARAMETER	: string tanggal dengan format DD/MM/YYYY}
	{RETURN		: Date}

	{KAMUS LOKAL}
	var
		convertedDate 	: Date;

	{ALGORITMA}
	begin
		convertedDate.day 	:= StrToInt(rawDate[1..2]);
		convertedDate.month := StrToInt(rawDate[4..5]);
		convertedDate.year 	:= StrToInt(rawDate[7..10]);

		StrToDate_ := convertedDate;
	end;

function DateToStr_(convertedDate: Date): string;
	{DESKRIPSI	: Mengubah format masukan tanggal dari format ADT Date ke format string}
	{PARAMETER	: ADT Date}
	{RETURN		: string dengan format DD/MM/YYYY}

	{KAMUS LOKAL}
	var
		rawDate 	: string;

	{ALGORITMA}
	begin
		rawDate := format('%.2d', [convertedDate.day]) + '/' + format('%.2d', [convertedDate.month]) + '/' + format('%.4d', [convertedDate.year]);
		DateToStr_ := rawDate;
	end;
end.