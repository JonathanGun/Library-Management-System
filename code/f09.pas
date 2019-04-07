unit f09;

interface
uses
    ubook;

procedure tambah_buku(ptrbook:pbook);

implementation
procedure tambah_buku(ptrbook:pbook);
var
    idbook:integer;
    booktitle:string;
    author:string;
    bookamount:integer;
    bookyear:integer;
    kategori:string;
begin
    writeln('$ tambah_buku');
    writeln('Masukkan informasi buku yang ditambahkan:');
    write('Masukkan id buku:');
    readln(idbook);
    ptrbook^[bookneff+1].id:=idbook;
    write('Masukkan judul buku:');
    readln(booktitle);
    ptrbook^[bookneff+1].title:=booktitle;
    write('Masukkan pengarang buku:');
    readln(author);
    ptrbook^[bookneff+1].author:=author;
    write('Masukkan jumlah buku:');
    readln(bookamount);
    ptrbook^[bookneff+1].qty:=bookamount;
    write('Masukkan tahun terbit buku:');
    readln(bookyear);
    ptrbook^[bookneff+1].year:=bookyear;
    write('Masukkan kategori buku:');
    readln(kategori);
    ptrbook^[bookneff+1].category:=kategori;
    writeln('Buku berhasil ditambahkan ke dalam sistem!');
end;

end. 
