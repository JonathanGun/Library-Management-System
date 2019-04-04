unit uuser;

interface

const
	MAXUSER = 1000;

type
	User = record
		username	: string;
		password	: string;
		fullname	: string;
		address		: string;
		isAdmin		: boolean;
	end;

	tuser = array [1..MAXUSER] of User;
	puser = ^tuser;

implementation

end.
