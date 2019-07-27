# alter table books add bestseller boolean;
drop procedure IF exists UpdateBestsellers;
delimiter $$
create procedure UpdateBestsellers()
begin
    declare bk_id int;
    declare rented int default 0;
    declare notrented int;
    declare finished int default 0;
    declare all_bestsellers cursor for select book_id from rents;
    declare continue handler for not found set finished = 1;
    open all_bestsellers;
    while (finished = 0) do
    fetch all_bestsellers into bk_id;
    select count(*) from rents
    where book_id = bk_id
    into rented;
    if (finished = 0) then
        if (rented >= 2) then
            update books
            set books.bestseller = true
            where books.book_id = bk_id;
            commit;
        else
            update books
            set books.bestseller = false
            where books.book_id = bk_id;
            commit;
        end if;
    end if;
    end while;
    select book_id from books
    where bestseller is null
    into notrented;
    update books
    set books.bestseller = false
    where books.book_id = notrented;
    commit;
end $$
delimiter ;

call UpdateBestsellers();
select * from books;
