unit f08;

interface
uses
    udate, ubook;

procedure lihat_laporan(ptrbook : pbook; ptr_hilang:pmissing);

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
