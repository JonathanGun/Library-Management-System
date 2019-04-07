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
function DateDifference_(date1, date2 : Date): integer;

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

function isKabisat(year: integer): boolean;
	{DESKRIPSI	: Menentukan jumlah hari dalam tanggal tesebut (terhitung dari 00/00/0000)}
	{PARAMETER	: 1 ADT Date}
	{RETURN		: berapa hari dalam tanggal tesebut (terhitung dari 00/00/0000)}
	{REFERENSI	: https://id.wikipedia.org/wiki/Tahun_kabisat}

	{KAMUS LOKAL}
	{ - }

	{ALGORITMA}
	begin
		if year mod 4 = 0 then begin
			if year mod 100 = 0 then begin
				if year mod 400 = 0 then begin
					isKabisat := true;
				end else begin
					isKabisat := false;
				end;
			end else begin
				isKabisat := true;
			end;
		end else begin
			isKabisat := false;
		end;
	end;

function DateToDays_(varDate : Date): integer;
	{DESKRIPSI	: Menentukan jumlah hari dalam tanggal tesebut (terhitung dari 00/00/0000)}
	{PARAMETER	: 1 ADT Date}
	{RETURN		: berapa hari dalam tanggal tesebut (terhitung dari 00/00/0000)}

	{KAMUS LOKAL}
	var
		i : integer;

	{ALGORITMA}
	begin
		DateToDays_ := 0;
		{tahun}
		for i := 0 to varDate.year-1 do begin
			if isKabisat(i) then begin
				DateToDays_ += 366;
			end else begin
				DateToDays_ += 365;
			end;
		end;

		{bulan}
		for i := 1 to varDate.month do begin
			{feb}
			if i = 2 then begin
				if isKabisat(varDate.year) then begin
					DateToDays_ += 29;
				end else begin
					DateToDays_ += 28;
				end;
			end else if i <= 7 then begin
				{jan, mar, mei, jul}
				if i mod 2 = 1 then begin
					DateToDays_ += 31;
				{apr, jun}
				end else begin
					DateToDays_ += 30;
				end;
			end else begin
				{ags, okt, des}
				if i mod 2 = 0 then begin
					DateToDays_ += 31;
				{sept, nov}
				end else begin
					DateToDays_ += 30;
				end;
			end;
		end;

		{hari}
		DateToDays_ += varDate.day;
	end;


function DateDifference_(date1, date2 : Date): integer;
	{DESKRIPSI	: Mencari selisih dari 2 tanggal (dalam satuan hari)}
	{PARAMETER	: 2 ADT Date}
	{RETURN		: berapa hari selisih kedua tanggal tersebut, dalam satuan hari (integer)}

	{KAMUS LOKAL}
	{ - }

	{ALGORITMA}
	begin
		DateDifference_ := 0;
		DateDifference_ += DateToDays_(date2) - DateToDays_(date1);

	end;
end.