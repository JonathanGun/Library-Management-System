unit k03_kel3_utils;
{Berisi fungsi-fungsi perantara yang vital untuk membantu unit-unit lain}
{REFERENSI	: https://stackoverflow.com/questions/27708404/crt-library-changes-console-encoding-pascal (clearscreen in windows)}

interface
uses
	crt;

{PUBLIC FUNCTIONS, PROCEDURE}
function StrToInt(rawString : string): integer;
function IntToStr(rawInt : integer): string;
procedure clrscr_();
procedure printFeatures();
function queryValid(q : string): boolean;

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
		if (rawInt < 0) then begin
			rawInt *= -1;
			isNeg := true;
		end else begin
			isNeg := false;
		end;

		IntToStr := '';
		while (rawInt <> 0) do begin
			IntToStr := chr((rawInt mod 10) + ord('0')) + IntToStr;
			rawInt := rawInt div 10;
		end;
		
		if (isNeg) then begin
			IntToStr := '-' + IntToStr;
		end;
	end;

procedure clrscr_();
	{DESKRIPSI 	: Menghapus layar cmd}
	{I.S.		: sembarang}
	{F.S.		: layar cmd kosong}
	{Proses		: menggunakan clrscr dan assign ulang input output}
	begin
		clrscr;
		assign(input,  ''); reset(input);
		assign(output, ''); rewrite(output);
	end;

procedure printFeatures();
	{DESKRIPSI	: Menampilkan fitur-fitur pada layar}
	{I.S. 		: Sembarang}
	{F.S.		: Fitur-fitur tertulis di layar}
	{Proses 	: Menulis fitur-fitur di layar}

	{ALGORITMA}
	begin
		writeln('Selamat datang di Perpustakaan Tengah Gurun'								);
		writeln('$ register			: Regitrasi Akun'										);
		writeln('$ login 			: Login'												);
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
	
end.