unit udate;
{Mengatur format tanggal dan konversinya dari string menjadi integer dan ADT Date}
{REFERENSI : http://forum.lazarus.freepascal.org/index.php?topic=27778.0 (Topic: What is the format string for padding a number with leading zeros?)}

interface
uses
	k03_kel3_utils;

{PUBLIC VARIABLE, CONST, ADT}
type
	{Definisi ADT Date}
	Date = record
		day			: integer;
		month		: integer;
		year		: integer;
	end;

{PUBLIC FUNCTIONS, PROCEDURE}
function DateDifference(date1, date2 : Date): longint;
function StrToDate(rawDate: string): Date;
function DateToStr(convertedDate: Date): string;
function DateToDays(varDate : Date): longint;
function DaysToDate(days : longint): Date;

implementation
{FUNGSI dan PROSEDUR}
function StrToDate(rawDate: string): Date;
	{DESKRIPSI	: Mengubah format masukan tanggal dari format string ke format ADT Date}
	{PARAMETER	: string tanggal dengan format DD/MM/YYYY}
	{RETURN		: Date}

	{ALGORITMA}
	begin
		StrToDate.day 	:= StrToInt(rawDate[1] + rawDate[2]);
		StrToDate.month := StrToInt(rawDate[4] + rawDate[5]);
		StrToDate.year 	:= StrToInt(rawDate[7] + rawDate[8] + rawDate[9] + rawDate[10]);
	end;

function formatDate(int, n : integer): string;
	{DESKRIPSI	: Mengubah integer tanggal menjadi string dengan format yang sesuai}
	{PARAMETER	: 2 integer, tanggal dan jumlah digit yang diinginkan}
	{RETURN		: string dengan format '0'...int}

	{KAMUS LOKAL}
	begin
		formatDate := IntToStr(int);
		while (length(formatDate) < n) do begin
			formatDate := '0' + formatDate;
		end;
	end;


function DateToStr(convertedDate: Date): string;
	{DESKRIPSI	: Mengubah format masukan tanggal dari format ADT Date ke format string}
	{PARAMETER	: ADT Date}
	{RETURN		: string dengan format DD/MM/YYYY}

	{ALGORITMA}
	begin
		DateToStr := formatDate(convertedDate.day, 2) + '/'
				   + formatDate(convertedDate.month, 2) + '/'
				   + formatDate(convertedDate.year, 4);
	end;

function isKabisat(year: integer): boolean;
	{DESKRIPSI	: Menentukan apakah tahun year kabisat}
	{PARAMETER	: integer, tahun yang ingin dicek}
	{RETURN		: true apabila tahun tsb kabisat}
	{REFERENSI	: https://id.wikipedia.org/wiki/Tahun_kabisat}

	{ALGORITMA}
	begin
		if (year mod 4 = 0) then begin
			if (year mod 100 = 0) then begin
				if (year mod 400 = 0) then begin
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

function DateToDays(varDate : Date): longint;
	{DESKRIPSI	: Menentukan jumlah hari dalam tanggal tesebut (terhitung dari 01/01/0000)}
	{PARAMETER	: 1 ADT Date}
	{RETURN		: berapa hari dalam tanggal tesebut (terhitung dari 01/01/0000)}

	{KAMUS LOKAL}
	var
		i : integer;

	{ALGORITMA}
	begin
		DateToDays := 0;
		{tahun}
		for i := 0 to varDate.year - 1 do begin
			if (isKabisat(i)) then begin
				DateToDays += 366;
			end else begin
				DateToDays += 365;
			end;
		end;

		{bulan}
		for i := 1 to varDate.month - 1 do begin
			{feb kabisat}
			if ((i = 2) and isKabisat(varDate.year)) then begin
				DateToDays += 29;

			{feb non kabisat}
			end else if ((i = 2) and not isKabisat(varDate.year)) then begin
				DateToDays += 28;

			{apr, jun, sept, nov}
			end else if ((i = 4) or (i = 6) or (i = 9) or (i = 11)) then begin
				DateToDays += 30;

			{jan, mar, mei, jul, ags, okt, des}
			end else begin
				DateToDays += 31;
			end;
		end;

		{hari}
		DateToDays += varDate.day;
	end;

function DaysToDate(days : longint): Date;
	{DESKRIPSI	: Mengubah dari jumlah hari menjadi Date terhitung dari tanggal (01/01/0000)}
	{PARAMETER	: jumlah hari (integer)}
	{RETURN		: Date yang merepresentasikan, terhitung sejak (01/01/0000)}

	{KAMUS LOKAL}
	var
		i 			: integer;
		enoughdays 	: boolean;

	{ALGORITMA}
	begin
		DaysToDate.year  := 0;
		DaysToDate.month := 1;
		DaysToDate.day 	 := 1;

		{tahun}
		i := 0;
		repeat
			enoughdays := false;
			if (isKabisat(i)) then begin
				if (days > 366) then begin
					DaysToDate.year += 1;
					days -= 366;
					enoughdays := true;
				end;
			end else begin
				if (days > 365) then begin
					DaysToDate.year += 1;
					days -= 365;
					enoughdays := true;
				end;
			end;
			i += 1;
		until (not enoughdays);

		{bulan}
		i := 1;
		repeat
			enoughdays := false;
			{feb kabisat}
			if ((i = 2) and isKabisat(DaysToDate.year)) then begin
				enoughdays := true;
				days -= 29;
				DaysToDate.month += 1;

			{feb non kabisat}
			end else if ((i = 2) and not isKabisat(DaysToDate.year)) then begin
				enoughdays := true;
				days -= 28;
				DaysToDate.month += 1;

			{apr, jun, sept, nov}
			end else if ((i = 4) or (i = 6) or (i = 9) or (i = 11)) then begin
				enoughdays := true;
				days -= 30;
				DaysToDate.month += 1;

			{jan, mar, mei, jul, ags, okt, des}
			end else begin
				enoughdays := true;
				days -= 31;
				DaysToDate.month += 1;
			end;

			i += 1;
		until (not enoughdays);

		{hari}
		DaysToDate.day := days;
	end;

function DateDifference(date1, date2 : Date): longint;
	{DESKRIPSI	: Mencari selisih dari 2 tanggal (dalam satuan hari)}
	{PARAMETER	: 2 ADT Date}
	{RETURN		: berapa hari selisih kedua tanggal tersebut, dalam satuan hari (integer)}

	{ALGORITMA}
	begin
		DateDifference := DateToDays(date2) - DateToDays(date1);
	end;
end.
