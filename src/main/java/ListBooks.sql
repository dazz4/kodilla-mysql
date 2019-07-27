drop procedure if exists ListBooks;

delimiter $$
create procedure ListBooks()
begin
    select * from books;
end $$
delimiter ;

call ListBooks();