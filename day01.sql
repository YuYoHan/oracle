create table book(
    bookId number PRIMARY KEY,
    bookName varchar2(50),
    price number,
    publisher varchar2(50)
);

drop table book;
select * from book;

create table customer(
    custId number PRIMARY KEY,
    name varchar2(20),
    address varchar2(100),
    phone varchar2(100)
);


create table orders(
    orderId number primary key,
    custId number REFERENCES customer(custId),
    bookId number REFERENCES book(bookId),
    salePrice number,
    orderDate DATE
);

desc book;
desc orders;

insert into book values(1, '�౸�� ����', 7000, '�½�����');
commit;
insert into book(bookId, bookName, price, publisher) 
    values(2, '�౸�ƴ� ����', 9000, '������');
    
insert into book(bookId, bookName, price, publisher) 
    values(3, '�౸�� ����', 22000, '���ѹ̵��');
insert into book(bookId, bookName, price, publisher) 
    values(4, '���� ���̺�', 13000, '���ѹ̵��');
insert into book(bookId, bookName, price, publisher) 
    values(5, '�ǰ� ����', 8000, '�½�����');
insert into book(bookId, bookName, price, publisher) 
    values(6, '���� �ܰ躰 ���', 6000, '�½�����');
insert into book(bookId, bookName, price, publisher) 
    values(7, '�߱��� �߾�', 20000, '�̻�̵��');
insert into book(bookId, bookName, price, publisher) 
    values(8, '�߱��� ��Ź��', 3000, '�̻�̵��');
insert into book(bookId, bookName, price, publisher) 
    values(9, '�ø��� �̾߱�', 7500, '�Ｚ��');
insert into book(bookId, bookName, price, publisher) 
    values(10, '�ø��� è�Ǿ�', 10000, 'Pearson');
    

commit;

// ���� ���� ����
column bookId format 9999;
column bookName format a20;
column price format 999,999;
column publisher format a20;
select * from book;
