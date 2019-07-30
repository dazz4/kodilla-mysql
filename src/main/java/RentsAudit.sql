create table rents_aud
(
    event_id        int(11)  NOT NULL auto_increment,
    event_date      datetime not null,
    event_type      varchar(10) default null,
    rent_id         int(11)  not null,
    old_book_id     int(11),
    new_book_id     int(11),
    old_reader_id   int(11),
    new_reader_id   int(11),
    old_rent_date   datetime,
    new_rent_date   datetime,
    old_return_date datetime,
    new_return_date datetime,
    primary key (`event_id`)
);

delimiter $$
create trigger rents_insert after insert on rents
    for each row
begin
    insert into rents_aud (event_date, event_type, rent_id, new_book_id, new_reader_id,
                           new_rent_date, new_return_date)
    values (curtime(), "INSERT", new.rent_id, new.book_id, new.reader_id, new.rent_date, new.return_date);
end $$
delimiter ;

insert into rents (book_id, reader_id, rent_date, return_date)
values (2, 4, curdate() - 7, null);
commit;

delimiter $$
create trigger rents_delete after delete on rents
    for each row
    begin
        insert into rents_aud(event_date, event_type, rent_id)
        values (curtime(), "DELETE", old.rent_id);
    end $$
delimiter ;

delete from rents where rent_id = 12;

delimiter $$
create trigger rents_update after update on rents
    for each row
    begin
        insert into rents_aud(event_date, event_type, rent_id, old_book_id, new_book_id, old_reader_id,
                              new_reader_id, old_rent_date, new_rent_date, old_return_date, new_return_date)
        values (curtime(), "UPDATE", old.rent_id, old.book_id, new.book_id, old.reader_id, new.reader_id,
                old.rent_date, new.rent_date, old.return_date, new.return_date );
    end $$
delimiter ;

update rents set return_date = curdate()
where rent_id=10;
commit;