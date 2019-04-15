unit k03_kel3_utils;
{Berisi fungsi-fungsi perantara yang vital untuk membantu unit-unit lain}
{REFERENSI	: https://stackoverflow.com/questions/27708404/crt-library-changes-console-encoding-pascal (clearscreen in windows)
			  https://stackoverflow.com/questions/6320003/how-do-i-check-whether-a-string-exists-in-an-array}

interface
uses
	ucsvwrapper,
	uuser, crt;

const
	delimiter = ',';
	
{PUBLIC FUNCTIONS, PROCEDURE}
function StrToInt(rawString : string): integer;
function IntToStr(rawInt : integer): string;
function IntToHex(n: Cardinal): string;
procedure clrscr_();
procedure printFeatures(pactiveUser : psingleuser);
function queryValid(q : string): boolean;
function readpass(): string;

implementation
{FUNGSI dan PROSEDUR}
function StrToInt(rawString : string): integer;
	{DESKRIPSI	: Mengubah string menjadi integer}
	{PARAMETER	: string berisi angka}
	{RETURN		: integer yang merepresentasikan string tersebut}

	{KAMUS LOKAL}
	var
		i 		: integer;
		done	: boolean;

	{ALGORITMA}
	begin
		{cari bilangan tak nol pertama dalam string tsb}
		i := 1;
		while (rawString[i] = '0') do begin
			i += 1;
		end;

		{skema pencarian dengan boolean}
		done := false;
		StrToInt := 0;
		while (not done) and (i <= length(rawString)) do begin
			if (rawString[i] <> '.') then begin
				StrToInt := StrToInt * 10 + (ord(rawString[i]) - ord('0'));
			end else begin 	{kalau string memuat titik, berhenti (karena hanya ingin integer nya saja)}
				done := true;
			end;
			i += 1;
		end;
	end;

function IntToStr(rawInt : integer): string;
	{DESKRIPSI	: Mengubah integer menjadi string}
	{PARAMETER	: integer yang ingin diubah menjadi string}
	{RETURN		: string yang merepresentasikan integer tersebut}

	{KAMUS LOKAL}
	var
		isNeg : boolean;

	{ALGORITMA}
	begin
		{kasus integer negatif}
		if (rawInt < 0) then begin
			rawInt *= -1;
			isNeg := true;
		end else begin
			isNeg := false;
		end;

		IntToStr := '';
		while (rawInt <> 0) do begin
			{ambil digit terakhir (mod 10), ubah jadi char bersesuaian}
			IntToStr := chr((rawInt mod 10) + ord('0')) + IntToStr;
			rawInt := rawInt div 10;
		end;
		
		{beri tanda negatif jika integer negatif}
		if (isNeg) then begin
			IntToStr := '-' + IntToStr;
		end;
	end;

function IntToHex(n: Cardinal): string;
	{DESKRIPSI	: Mengubah 32-bit unsigned integer (Cardinal) menjadi string hexadecimalnya}
	{PARAMETER	: integer yang ingin diubah menjadi string hexadecimal}
	{RETURN		: string yang merepresentasikan nilai hexadecimal integer tersebut}

	{KAMUS LOKAL}
	var
		tmp : integer;

	{ALGORITMA}
	begin
	    IntToHex := '';
	    {skema yang sama seperti StrToInt}
	    while (n <> 0) do begin
	    	tmp := n mod 16;
	    	{bagi 2 kasus, kurang dari 10 dan di atas 10}
	    	if (tmp < 10) then begin
	    		{ubah jadi char yang bersesuaian}
	    		IntToHex := chr(tmp + ord('0')) + IntToHex;
	    	end else begin
	    		tmp -= 10;
	    		{10 -> 'a', 11 -> 'b', 12 -> 'c', 13 -> 'd', 14 -> 'e', 15 -> 'f'}
	    		IntToHex := chr(tmp + ord('a')) + IntToHex;
	    	end;
	        n := n div 16;
	    end;
	end;

procedure clrscr_();
	{DESKRIPSI 	: Menghapus layar cmd}
	{I.S.		: sembarang}
	{F.S.		: layar cmd kosong}
	{Proses		: menggunakan clrscr dan assign ulang input output}

	{ALGORITMA}
	begin
		clrscr;
		assign(input,  ''); reset(input);
		assign(output, ''); rewrite(output);
	end;

procedure printFeatures(pactiveUser : psingleuser);
	{DESKRIPSI	: Menampilkan fitur-fitur pada layar}
	{I.S. 		: Sembarang}
	{F.S.		: Fitur-fitur tertulis di layar}
	{Proses 	: Menulis fitur-fitur di layar}

	{ALGORITMA}
	begin
		writeln('Selamat datang di Perpustakaan Tengah Gurun, ', unwraptext(pactiveUser^.username), '!'		);
		{Prompt pada Admin}
		if (pactiveUser^.isAdmin) then begin
			writeln('$ register			: Regitrasi Akun'										);
			writeln('$ logout			: Logout'												);
			writeln('$ cari				: Pencarian Buku berdasar Kategori'						);
			writeln('$ caritahunterbit 		: Pencarian Buku berdasar Tahun Terbit' 			);
			writeln('$ pinjam_buku 			: Pemimjaman Buku'									);
			writeln('$ kembalikan_buku 		: Pengembalian Buku'								);
			writeln('$ lapor_hilang			: Melaporkan Buku Hilang'							);
			writeln('$ lihat_laporan 		: Melihat Laporan Buku yang Hilang'					);
			writeln('$ tambah_buku 			: Menambahkan Buku Baru ke Sistem'					);
			writeln('$ tambah_jumlah_buku 		: Melakukan Penambahan Jumlah Buku ke Sistem'	);
			writeln('$ riwayat 			: Melihat Riwayat Peminjaman'				 			);
			writeln('$ statistik 			: Melihat Statistik'					 			);
			writeln('$ load 				: Load File'							 			);
			writeln('$ save 				: Save File'							 			);
			writeln('$ cari_anggota 			: Pencarian Anggota'				 			);
			writeln('$ exit				: Exit'										 			);

		{Prompt pada pengguna yang sudah login}
		end else if (pactiveUser^.username <> wraptext('Anonymous')) then begin
			writeln('$ logout			: Logout'												);
			writeln('$ cari				: Pencarian Buku berdasar Kategori'						);
			writeln('$ caritahunterbit 		: Pencarian Buku berdasar Tahun Terbit' 			);
			writeln('$ pinjam_buku 			: Pemimjaman Buku'									);
			writeln('$ kembalikan_buku 		: Pengembalian Buku'								);
			writeln('$ lapor_hilang			: Melaporkan Buku Hilang'							);
			writeln('$ load 				: Load File'							 			);
			writeln('$ save 				: Save File'							 			);
			writeln('$ exit				: Exit'										 			);

		{Prompt pada penggunayang belum login}
		end else begin
			writeln('$ login 			: Login'												);
			writeln('$ cari				: Pencarian Buku berdasar Kategori'						);
			writeln('$ caritahunterbit 		: Pencarian Buku berdasar Tahun Terbit' 			);
			writeln('$ lapor_hilang			: Melaporkan Buku Hilang'							);
			writeln('$ exit				: Exit'										 			);
		end;
	end;

function queryValid(q : string): boolean;
	{DESKRIPSI	: mengecek apakah query yang dimasukkan user valid/tidak}
	{PARAMETER	: query input user }
	{RETURN 	: boolean apakah query valid }

	{KAMUS LOKAL}
	const
		NUMQUERIES = 17;
		QUERIES : array [1..NUMQUERIES] of string =
		('register', 'login', 'cari', 'caritahunterbit', 'pinjam_buku', 'kembalikan_buku',
		 'lapor_hilang', 'lihat_laporan', 'tambah_buku', 'tambah_jumlah_buku', 'riwayat',
		 'statistik', 'load', 'save', 'cari_anggota', 'exit', 'logout');

	var
		str : string;
		i 	: integer;

	{ALGORITMA}
	begin
		queryValid := false;
		for i := 1 to NUMQUERIES do begin
			str := QUERIES[i];
			if (q = str) then begin
				queryValid := true;
			end;
		end;
	end;

function readpass(): string;
	{DESKRIPSI	: membuat agar password tidak terlihat di layar}
	{PARAMETER	: - }
	{RETURN 	: string password}

	{KAMUS LOKAL}
	var
		ch: char;

	{ALGORITMA}
	begin
		readpass := '';
		ch := readkey;
		while (ch <> #13) do begin
			write('*');
			readpass += ch;
			ch := readkey;
		end;
	end;
end.