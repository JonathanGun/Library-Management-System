unit f08;
{DESKRIPSI}
{REFERENSI}

interface
uses
    udate,
    ubook;

{PUBLIC, VARIABLE, CONST, ADT}
{-}

{PUBLIC, FUNCTION, PROCEDURE}
procedure lihat_laporan(ptrbook : pbook; ptr_hilang:pmissing);

implementation
{PRIVATE VARIABLE, CONST, ADT}
{-}

{FUNGSI dan PROSEDUR}
procedure lihat_laporan(ptrbook : pbook; ptr_hilang:pmissing);
    {DESKRIPSI  : menampilkan data-data buku yang hilang}
    {I.S        : ptrbook (pointer pada book.csv)}
    {F.S        : data buku hilang ditampilkan }
    {Proses     : menampilkan data-data buku hilang berdasarkan book.csv}

    {KAMUS LOKAL}
    var
        idx, i  : integer;
    
    {ALGORITMA}
    begin
        writeln('$ lihat_laporan');
        writeln('Buku yang hilang :');
        for i:= 1 to missingNeff do begin
            write(ptr_hilang^[i].id, ' | ');

            idx:=checklocation(ptr_hilang^[i].id,ptrbook);
            write(ptrbook^[idx].title, ' | ');
            
            writeln(DateToStr_(ptr_hilang^[i].reportdate));
        end;
    end;

end. 
