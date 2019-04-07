unit f08;

interface
uses
    udate, ubook;

procedure lihat_laporan(ptrbook : pbook; ptr_hilang:pmissing);
{DESKRIPSI	: menampilkan data-data buku yang hilang}
{I.S		: ptrbook (pointer pada book.csv)}
{F.S		: data buku hilang ditampilkan }
{Proses     : menampilkan data-data buku hilang berdasarkan book.csv}

implementation
procedure lihat_laporan(ptrbook : pbook; ptr_hilang:pmissing);
var idx,i:integer;
begin
    writeln('$ lihat_laporan');
    writeln('Buku yang hilang :');
    for i:= 1 to missingNeff do
    begin

        write(ptr_hilang^[i].id);
        write(' | ');
        idx:=checklocation(ptr_hilang^[i].id,ptrbook);
        write(ptrbook^[idx].title);
        write(' | ');
        writeln(DateToStr_(ptr_hilang^[i].reportdate));
    end;
end;

end. 
