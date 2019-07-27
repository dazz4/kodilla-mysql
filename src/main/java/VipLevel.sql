drop function if exists VipLevel;

delimiter $$
create function VipLevel(booksrented int) returns varchar(20) deterministic
begin
    declare result varchar(255) default 'Standard customer';
    if booksrented >= 10 then
        set result = 'Gold customer';
    elseif booksrented >= 5 and booksrented < 10 then
        set result = 'Silver customer';
    elseif booksrented >= 2 and booksrented < 5 then
        set result = 'Bronze customer';
    end if;
    return result;
end $$
delimiter ;

select VipLevel(2);
