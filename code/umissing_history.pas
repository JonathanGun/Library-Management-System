unit umissing_history;

interface
uses udate;

const
	MAXMISSING = 1000;

type
	MissingBook = record
		username	: string; {User.username}
		id 			: integer;
		reportDate	: Date;
	end;

	tmissing= array [1..MAXMISSING] of MissingBook;
	pmissing= ^tmissing;

implementation

end.