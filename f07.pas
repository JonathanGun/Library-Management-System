unit f07;

interface
uses
    ubook,udate;

procedure lapor_hilang(ptr_hilang:pmissing ; user : string);

implementation
procedure lapor_hilang(ptr_hilang:pmissing ; user : string);
{DESKRIPSI	: Menerima laporan buku hilang dengan menerima data id buku, judul buku, dan tanggal pelaporan}
{I.S		: ptr_hilang (pointer pada book.csv)}
{F.S		: data buku hilang tersimpan }

{kamus lokal}
var
    idbook: integer;
    bookname: string;
    date: string;

{algoritma}
begin
    writeln('$ lapor_hilang');
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
