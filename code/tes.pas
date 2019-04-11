program tes;
uses crt;

var tmp : string;
i : integer;
j : char;
begin
	assign(input, ''); reset(input);
	assign(output, ''); rewrite(output);
	for j := '0' to '9' do writeln(ord(j));
	for i := 0 to 9 do writeln(chr(48));
	writeln('tes');
	for j := 'a' to 'z' do writeln(ord(j));
	for j := 'A' to 'Z' do writeln(ord(j));
end.