drop table if exists stats;
create table stats
(
    stat_id       int(11)     not null auto_increment,
    stat_datetime datetime    not null,
    stat          varchar(20) not null,
    value         int(11)     not null,
    primary key (stat_id)
);

drop view if exists bestsellers_count;
create view bestsellers_count as
select count(*) from books
where bestseller = true;

drop procedure if exists UpdateStats;
delimiter $$
create procedure UpdateStats()
begin
    declare bestcount int;
    call UpdateBestsellers();
    select * from bestsellers_count into bestcount;
    insert into stats (stat_datetime, stat, value)
    values (curtime(), "BESTSELLERS", bestcount);
    commit;
end $$
delimiter ;

create event UPDATE_STATS_EVENT
    on schedule every 1 minute do
    call UpdateStats();

show processlist;
#drop event UPDATE_STATS_EVENT;