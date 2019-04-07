unit f09;
{DESKRIPSI}
{REFERENSI}

interface
uses
    ubook;
{PUBLIC, VARIABLE, CONST, ADT}
{-}

{PUBLIC, FUNCTION, PROCEDURE}
procedure tambah_buku(ptrbook:pbook);

implementation
{PRIVATE VARIABLE, CONST, ADT}
{-}

{FUNGSI dan PROSEDUR}
procedure tambah_buku(ptrbook:pbook);
{DESKRIPSI	: menerima data buku baru dan memasukkannya ke book.csv,dengan menerima masukkan id buku, judul
              pengarang,jumlah,tahun terbit,dan kategori}
{I.S		: ptrbook(pointer pada book.csv)}
{F.S		: data buku baru tersimpan }
{Proses     : }
{KAMUS LOKAL}
var
    idbook      :integer;
    booktitle   :string;
    author      :string;
    bookamount  :integer;
    bookyear    :integer;
    kategori    :string;

{ALGORITMA}
begin
    writeln('Masukkan informasi buku yang ditambahkan:');
    write('Masukkan id buku:');
    readln(idbook);
    ptrbook^[bookNeff+1].id:=idbook;

    write('Masukkan judul buku:');
    readln(booktitle);
    ptrbook^[bookNeff+1].title:=booktitle;

    write('Masukkan pengarang buku:');
    readln(author);
    ptrbook^[bookNeff+1].author:=author;

    write('Masukkan jumlah buku:');
    readln(bookamount);
    ptrbook^[bookNeff+1].qty:=bookamount;

    write('Masukkan tahun terbit buku:');
    readln(bookyear);
    ptrbook^[bookNeff+1].year:=bookyear;

    write('Masukkan kategori buku:');
    readln(kategori);
    ptrbook^[bookNeff+1].category:=kategori;

    bookNeff += 1;
    writeln('Buku berhasil ditambahkan ke dalam sistem!');
end;

end. 
