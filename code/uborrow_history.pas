unit uborrow_history;

interface
uses udate;

const
	MAXBORROW = 1000;

type
	BorrowHistory = record
		username 	: string; {User.username}
		id 			: integer; {Book.id}
		borrowDate	: Date;
		returnDate	: Date;
		isBorrowed	: boolean;
	end;

	tborrow = array [1..MAXBORROW] of BorrowHistory;
	pborrow = ^tborrow;

implementation

end.