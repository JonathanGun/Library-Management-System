unit udate;

interface
uses sysutils;

type
	Date = record
		day			: integer;
		month		: integer;
		year		: integer;
	end;
function StrToDate_(rawDate: string): Date;

implementation
function StrToDate_(rawDate: string): Date;
	var
		convertedDate 	: Date;
	begin
		convertedDate.day 	:= StrToInt(rawDate[1..2]);
		convertedDate.month := StrToInt(rawDate[4..5]);
		convertedDate.year 	:= StrToInt(rawDate[7..10]);

		StrToDate_ := convertedDate;
	end;

end.