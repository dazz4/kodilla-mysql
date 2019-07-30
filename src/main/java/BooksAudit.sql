drop trigger if exists books_insert;
drop trigger if exists books_delete;
drop trigger if exists books_update;
drop table if exists books_aud;

create table books_aud
(
    event_id            int(11)  not null auto_increment,
    event_date          datetime not null,
    event_type          varchar(10) default null,
    book_id             int(11)  not null,
    old_book_title      varchar(255),
    new_book_title      varchar(255),
    old_book_pubyear    int(11),
    new_book_pubyear    int(11),
    old_book_bestseller boolean,
    new_book_bestseller boolean,
    primary key (`event_id`)
);

delimiter $$
create trigger books_insert after insert on books
    for each row
begin
    insert into books_aud(event_date, event_type, book_id, new_book_title, new_book_pubyear, new_book_bestseller)
    values (curdate(), "INSERT", new.book_id, new.title, new.pubyear, new.bestseller);
end $$
delimiter ;

insert into books (title, pubyear, bestseller)
values ("Harry Potter", 1899, true);

delimiter $$
create trigger books_delete after delete on books
    for each row
    begin
        insert into books_aud (event_date, event_type, book_id, old_book_title, old_book_pubyear, old_book_bestseller)
        values (curdate(), "DELETE", old.book_id, old.title, old.pubyear, old.bestseller);
    end $$
delimiter ;

delete from rents where book_id = 2;
delete from books where books.book_id = 2;

delimiter $$
create trigger books_update after update on books
    for each row
    begin
        insert into books_aud(event_date, event_type, book_id, old_book_title, new_book_title,
                              old_book_pubyear, new_book_pubyear, old_book_bestseller, new_book_bestseller)
        values (curdate(), "UPDATE", book_id, old.title, new.title, old.pubyear, new.pubyear, old.bestseller, new.bestseller);
    end $$
delimiter ;

update books set pubyear = 2000
where book_id = 1;
commit;