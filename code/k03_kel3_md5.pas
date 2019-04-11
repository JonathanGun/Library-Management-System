unit k03_kel3_md5;
{Hashing dengan metode MD5}
{REFERENSI : https://en.wikipedia.org/wiki/MD5#Algorithm
			 https://tr.opensuse.org/MD5
			 https://rosettacode.org/wiki/MD5/Implementation
			 .. dan masih banyak lagi}

{DISCLAIMER : saya hanya mengikuti pseudocode yang ada di wikipedia
			  dengan bantuan google dan stackoverflow, bukan berarti
			  saya paham masing-masing barisnya}

interface
{PUBLIC VARIABLE, CONST, ADT}
uses
	k03_kel3_utils;

{PUBLIC FUNCTION, PROCEDURE}
function hashMD5(str: string): string;

implementation
function leftrotate(x, c: Cardinal): Cardinal;
	{DESKRIPSI : merotasi 32 bit yang merepresentasikan 1 chunk string}
	{PARAMETER : }
	{RETURN : }
	begin
		leftrotate := (x shl c) or (x shr (32-c));
	end;

{$asmmode intel}
function Swap32(ALong: Cardinal): Cardinal; Assembler; 
	{DESKRIPSI : menukar isi memori 32 bit}
	{PARAMETER : 32 bit unsigned integer (Cardinal)}
	{RETURN : }
	asm 
		BSWAP eax
	end;


function hashMD5(str: string): string;
	{DESKRIPSI : melakukan hashing pada string, terutama password}
	{PARAMETER : string yang ingin dihash}
	{RETURN : string hasil hash}
	{DISCLAIMER : PSEUDOCODE ADA DI WIKIPEDIA}
	const
		{s : jumlah shift tiap 'round'}
		s: array[0..63] of Cardinal = (
			7, 12, 17, 22,  7, 12, 17, 22,  7, 12, 17, 22,  7, 12, 17, 22,
			5,  9, 14, 20,  5,  9, 14, 20,  5,  9, 14, 20,  5,  9, 14, 20,
			4, 11, 16, 23,  4, 11, 16, 23,  4, 11, 16, 23,  4, 11, 16, 23,
			6, 10, 15, 21,  6, 10, 15, 21,  6, 10, 15, 21,  6, 10, 15, 21 );

		{K[i] : floor(2^32 × abs(sin(i + 1)))}
		K: array[0..63] of Cardinal = (
			$d76aa478, $e8c7b756, $242070db, $c1bdceee,
			$f57c0faf, $4787c62a, $a8304613, $fd469501,
			$698098d8, $8b44f7af, $ffff5bb1, $895cd7be,
			$6b901122, $fd987193, $a679438e, $49b40821,
			$f61e2562, $c040b340, $265e5a51, $e9b6c7aa,
			$d62f105d, $02441453, $d8a1e681, $e7d3fbc8,
			$21e1cde6, $c33707d6, $f4d50d87, $455a14ed,
			$a9e3e905, $fcefa3f8, $676f02d9, $8d2a4c8a,
			$fffa3942, $8771f681, $6d9d6122, $fde5380c,
			$a4beea44, $4bdecfa9, $f6bb4b60, $bebfbc70,
			$289b7ec6, $eaa127fa, $d4ef3085, $04881d05,
			$d9d4d039, $e6db99e5, $1fa27cf8, $c4ac5665,
			$f4292244, $432aff97, $ab9423a7, $fc93a039,
			$655b59c3, $8f0ccc92, $ffeff47d, $85845dd1,
			$6fa87e4f, $fe2ce6e0, $a3014314, $4e0811a1,
			$f7537e82, $bd3af235, $2ad7d2bb, $eb86d391 );

	var
		a0, b0, c0, d0 	: Cardinal;
		a, b, c, d 		: Cardinal; 
		f, g, dTemp		: Cardinal;
		
		len, i 	: integer;
		msg 	: array[0..63] of Char;
		{array M menyimpan 16 32-bit unsigned integer yang merepresentasikan string tsb}
		M 		: array[0..15] of Cardinal absolute msg; 

	begin
		{INISIASI}
		a0 := $67452301;
		b0 := $efcdab89;
		c0 := $98badcfe;
		d0 := $10325476;

		len := length(Str);

		fillChar(msg, 64, 0);

		for i:=1 to len do begin
			msg[i-1] := Str[i];
		end;

		//append "1" bit to message
		msg[len] := chr(128);

		//append original length in bits mod (2 pow 64) to message
		msg[63-7] := chr(8*Len);

		//Process each 512-bit chunk of message- 1 only have 1 chunk

		//Initialize hash value for this chunk:
		A := a0;
		B := b0;
		C := c0;
		D := d0;

		//Main loop:
		for i := 0 to 63 do begin
			if (i >= 0) and (i <= 15) then begin
				F := (B and C) or ((not B) and D);
				g := i;
			end else if (i >= 16) and (i <= 31) then begin
				F := (D and B) or ((not D) and C);
				g := (5*i + 1) mod 16;
			end else if (i >= 32) and (i <= 47) then begin
				F := B xor C xor D;
				g := (3*i + 5) mod 16;
			end else if (i >= 48) and (i <= 63) then begin
				F := C xor (B or (not D));
				g := (7*i) mod 16;
			end;

			dTemp := D;
			D := C;
			C := B;
			B := B + leftrotate((A + F + K[i] + M[g]), s[i]);
			A := dTemp;
		end;

		a0 := Swap32(a0 + A);
		b0 := Swap32(b0 + B);
		c0 := Swap32(c0 + C);
		d0 := Swap32(d0 + D);

		hashMD5 := (IntToHex(a0) + IntToHex(b0) + IntToHex(c0)  + IntToHex(d0));
	end;
end.