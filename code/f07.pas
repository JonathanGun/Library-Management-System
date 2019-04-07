unit f07;
{DESKRIPSI}
{REFERENSI}

interface
uses
    ubook,
    udate;

{PUBLIC, VARIABLE, CONST, ADT}
{-}

{PUBLIC, FUNCTION, PROCEDURE}
procedure lapor_hilang(ptr_hilang:pmissing ; user : string);

implementation
{PRIVATE VARIABLE, CONST, ADT}
{-}

{FUNGSI dan PROSEDUR}
procedure lapor_hilang(ptr_hilang:pmissing ; user : string);
    {DESKRIPSI	: Menerima laporan buku hilang dengan menerima data id buku, judul buku, dan tanggal pelaporan}
    {I.S		: ptr_hilang (pointer pada book.csv)}
    {F.S		: data buku hilang tersimpan }
    {Proses     : }
    
    {KAMUS LOKAL}
    var
        idbook: integer;
        bookname: string;
        date: string;

    {ALGORITMA}
    begin
        writeln('Masukkan id buku:');
        readln(idbook);

        writeln('Masukkan judul buku:');
        readln(bookname);

        writeln('Masukkan tanggal pelaporan:');
        readln(date);

        writeln('Laporan berhasil diterima');

        ptr_hilang^[missingNeff+1].id:=idbook;
        ptr_hilang^[missingNeff+1].reportDate:=StrToDate_(date);
        ptr_hilang^[missingNeff+1].username:= user;
        
        missingNeff += 1;
    end;

end. 
