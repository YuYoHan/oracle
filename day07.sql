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

insert into newbook values(1, '����ִ� JPA', '�迵��', 35000);
insert into neworders values(1, 1, 1, 35000, sysdate);

select * from neworders;

drop table neworders;
drop table newcustomer;
drop table newBook;

// ������� ���ǻ縦 ���ļ� PK ����
create table newBook(
    bookname varchar2(50),
    publisher VARCHAR2(50),
    price number,
    primary key(bookname, publisher)
);
insert into newBook values ('��մ� JPA', '�迵��', 35000);

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
insert into newcustomer values (1, '������', '���α�', '010-0000-0000');
insert into neworders values (1, 1, '��մ� JPA', '�迵��');
// ���� ���Ἲ : �θ� Ű�� ����.
insert into neworders values (4, 1, '��մ� JPA', '�迵��');

drop table neworders;

---


