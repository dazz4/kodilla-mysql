drop table books, readers, rents;

create table books
(
    book_id int(11)      not null auto_increment,
    title   varchar(255) not null,
    pubyear int(11)      not null,
    primary key (book_id)
);

create table readers
(
    reader_id int(11)      not null auto_increment,
    firstname varchar(255) not null,
    lastname  varchar(255) not null,
    peselid   varchar(11)      not null,
    vip_level varchar(20),
    primary key (reader_id)
);

create table rents
(
    rent_id     int(11)  not null auto_increment,
    book_id     int(11)  not null,
    reader_id   int(11)  not null,
    rent_date   datetime not null,
    return_date datetime,
    primary key (rent_id),
    foreign key (book_id) references books (book_id),
    foreign key (reader_id) references readers (reader_id)
);

