unit f07;

interface
uses
    ubook,udate;

var
    idbook: integer;
    bookname: string;
    date: string;

procedure lapor_hilang(ptr_hilang:pmissing ; user : string);

implementation
procedure lapor_hilang(ptr_hilang:pmissing ; user : string);
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
