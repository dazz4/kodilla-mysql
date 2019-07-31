explain select title from books;
create index booksin on books (title);
explain select title from books;

explain select firstname, lastname from readers;
create index readerin on readers (firstname, lastname);
explain select firstname, lastname from readers;
