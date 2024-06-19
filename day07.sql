create table newBook(
    bookId number primary key,
    bookname varchar2(50) not null,
    publisher VARCHAR2(50) ,
    price number 
);

create table newcustomer(
    custId number primary key,
    name varchar2(40),
    addr varchar2(40),
    phone varchar2(40)
);

create table neworders(
    orderId number primary key,
    custId number references newcustomer(custId),
    bookId number references newBook(bookId),
    salePrice number ,
    orderDate date default sysdate
);

select * from neworders;

delete newbook where bookId > 5;
delete newcustomer where custId > 5;

create table newBook(
    bookId number,
    bookname varchar2(50) not null,
    publisher VARCHAR2(50),
    price number,
    primary key (bookId)
);
create table neworders(
    orderId number,
    custId number,
    bookId number,
    salePrice number,
    orderDate date default sysdate,
    primary key (orderId),
    foreign key(custId) references newcustomer(custId),
    foreign key(bookId) references newbook(bookId)
);

insert into newbook values(1, '재미있는 JPA', '김영한', 35000);
insert into neworders values(1, 1, 1, 35000, sysdate);

select * from neworders;

drop table neworders;
drop table newcustomer;
drop table newBook;

// 도서명과 출판사를 합쳐서 PK 설정
create table newBook(
    bookname varchar2(50),
    publisher VARCHAR2(50),
    price number,
    primary key(bookname, publisher)
);
insert into newBook values ('재밌는 JPA', '김영한', 35000);

create table newcustomer(
    custId number primary key,
    name varchar2(40),
    addr varchar2(40),
    phone varchar2(40)
);

create table neworders (
    orderId number primary key,
    custId number references newcustomer(custId),
    bookname varchar2(50),
    publisher varchar2(50),
    foreign key(bookname, publisher) references newbook(bookname, publisher)
);
select * from newcustomer;
select * from newBook;
select * from neworders;
insert into newcustomer values (1, '유요한', '구로구', '010-0000-0000');
insert into neworders values (1, 1, '재밌는 JPA', '김영한');
// 참조 무결성 : 부모 키가 없다.
insert into neworders values (4, 1, '재밌는 JPA', '김영한');

drop table neworders;

---


