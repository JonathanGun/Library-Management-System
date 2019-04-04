unit ureturn_history;

interface
uses udate;

const
	MAXRETURN = 1000;

type
	ReturnHistory = record
		username	: string; {User.username}
		id			: integer; {Book.id}
		returnDate	: Date;
	end;

	treturn = array [1..MAXRETURN] of ReturnHistory;
	preturn = ^treturn;

implementation

end.

