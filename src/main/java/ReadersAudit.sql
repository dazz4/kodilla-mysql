drop trigger if exists reader_insert;
drop trigger if exists reader_delete;
drop trigger if exists reader_update;
drop table if exists readers_aud;

create table readers_aud
(
    event_id      int(11)  NOT NULL auto_increment,
    event_date    datetime not null,
    event_type    varchar(10) default null,
    reader_id     int(11),
    new_firstname varchar(255),
    old_firstname varchar(255),
    new_lastname  varchar(255),
    old_lastname  varchar(255),
    new_peselid   varchar(11),
    old_peselid   varchar(11),
    new_vip_level varchar(20),
    old_vip_level varchar(20),
    primary key (event_id)
);

delimiter $$
create trigger reader_insert after insert on readers
    for each row
    begin
        insert into readers_aud(event_date, event_type, reader_id, new_firstname, new_lastname, new_peselid, new_vip_level)
        values (curtime(), "INSERT", new.reader_id, new.firstname, new.lastname, new.peselid, new.vip_level);
    end $$
delimiter ;

insert into readers(firstname, lastname, peselid, vip_level)
values ("Dariusz", "Kaminski", "12345678", "Standard customer");

delimiter $$
create trigger reader_delete after delete on readers
    for each row
    begin
        insert into readers_aud(event_date, event_type, reader_id, old_firstname, old_lastname, old_peselid, old_vip_level)
        values (curtime(), "DELETE", old.reader_id, old.firstname, old.lastname, old.peselid, old.vip_level);
    end $$
delimiter ;

delete from rents where reader_id = "3";
delete from readers where reader_id = "3";

delimiter $$
create trigger reader_update after update on readers
    for each row
begin
    insert into readers_aud(event_date, event_type, reader_id, new_firstname, old_firstname,
                            new_lastname, old_lastname, new_peselid, old_peselid, new_vip_level, old_vip_level)
    values (curtime(), "UPDATE", old.reader_id, new.firstname, old.firstname, new.lastname, old.lastname,
            new.peselid, old.peselid, new.vip_level, old.vip_level);
end $$
delimiter ;

update readers set firstname = "Kamil" where reader_id = 7;

