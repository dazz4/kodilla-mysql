create view books_and_readers as
select rd.reader_id, rd.firstname, rd.lastname, bk.title, rt.rent_date, rt.return_date
from readers rd,
     books bk,
     rents rt
where rt.book_id = bk.book_id
  and rt.reader_id = rd.reader_id
order by rt.rent_date;

select * from books_and_readers
where rent_date >= curdate() - 11;


