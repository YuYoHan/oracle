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
    orderDate DATE default sysdate
);

desc book;
desc orders;
drop table orders;

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

// �ѱ��� �ѱ��� ǥ���ϱ� ���ؼ� varchar2(3)
insert into customer values(1, '������', '���� ��ü��Ÿ','010-5000-0001');
insert into customer values(2, '�迬��', '���ѹα� ����','010-5000-0002');
insert into customer values(3, '��̶�', '���ѹα� ������','010-5000-0003');
insert into customer values(4, '�߽ż�', '�̱� Ŭ������','010-5000-0004');
insert into customer values(5, '�ڼ���', '���ѹα� ����', null);
select * from customer;

// ���̺� ����
alter table customer modify address varchar2(99);
// ������ ����
update customer set phone = '010-5000-0005' where custId = 5;
select * from customer where custId = 5;

insert into orders (orderId, custId, bookId, saleprice) values(1, 2, 5, 8000);
select * from orders;
SELECT b.bookName, c.name
FROM book b
JOIN customer c ON b.bookId = 2 AND c.custId = 5;

insert into orders (orderId, custId, bookId, saleprice, orderDate) 
values(2, 1, 3, 8000, '2024/06/07');
insert into orders (orderId, custId, bookId, saleprice, orderDate) 
values(3, 2, 5, 6000, '2024/06/01');
insert into orders (orderId, custId, bookId, saleprice) 
values(4, 3, 6, 20000);
insert into orders (orderId, custId, bookId, saleprice) 
values(5, 4, 7, 12000);
insert into orders (orderId, custId, bookId, saleprice, orderDate) 
values(6, 1, 2, 13000, '2024/06/05');
insert into orders (orderId, custId, bookId, saleprice, orderDate) 
values(7, 4, 8, 12000, '2024/05/05');
insert into orders (orderId, custId, bookId, saleprice) 
values(8, 3, 10, 7000);
insert into orders (orderId, custId, bookId, saleprice) 
values(9, 2, 10, 13000);
insert into orders (orderId, custId, bookId, saleprice, orderDate) 
values(10, 3, 8, 7000, '2024/06/06');
insert into orders (orderId, custId, bookId, saleprice, orderDate) 
values(11, 3, 8, 9000, '2024/06/10');
select * from orders;

// ������ �ּ�
select address from customer;
// �迬�� ���� �ּ�
select address from customer where name = '�迬��';
// ���ѹ̵��� �Ⱓ�ϴ� ������ ������� ������ ��ȸ
select bookName, price from book where publisher = '���ѹ̵��';
// ���ѹ̵��� �Ⱓ�ϴ� ��� ������ ������ȣ, ������, ����, ���ǻ� ��ȸ
select * from book where publisher = '���ѹ̵��';
// ��� ���ǻ� ����� ���
select publisher from book;
// �ߺ������ϰ� ���
select DISTINCT publisher from book;

// ����
// ������ 20000�� �̻��� ������ ����� ���
select * from book where price >= 20000;
// ���ǻ簡 �½������� �ƴ� ��� ���� ����� ���
select * from book where publisher <> '��������';
// 2024�� 6�� 10�� �ֹ��� ������ȣ�� ����ȣ�� ���
select bookId, custId from orders where orderDate = '2024/06/10';
// �̻�̵��� �Ⱓ�ϴ� �����߿� ������ 20000�� �̻��� ������ȣ, ������ ���
select bookId, bookName from book where price >= 20000 and publisher = '�̻�̵��';
// �̻�̵� ���ѹ̵��� �Ⱓ�ϴ� ������ ������ȣ, ������, ���ǻ���� ���
select bookId, bookName, publisher from book 
where publisher = '�̻�̵��' or publisher = '���ѹ̵��';
select bookId, bookName, publisher from book 
where publisher in ('�̻�̵��', '���ѹ̵��');

// �̻�̵� �ƴϰ� ���ѹ̵� �ƴ� ���ǻ��� ������ȣ, ������, ���ǻ�� ���
select bookId, bookName, publisher from book where publisher not in ('�̻�̵��', '���ѹ̵��');
// �̻�̵� ���ѹ̵��� �����ϴ� ������ ������ 20000�̻��� ������ȣ, ������, ���ǻ�� ���
select bookId, bookName, publisher from book 
where publisher in ('�̻�̵��','���ѹ̵��') and price >= 20000;
// ������ 10000�� �̻� 20000�� ������ ������ ������ȣ, ���ǻ��, ������ ���
select bookId, publisher, price from book where price BETWEEN 10000 and 20000;
// ���ѹ̵� �̻�̵��� �����ϴ� ������ ������ 10000�� �̻� 30000�� ������ ���� ���� ���
select * from book where (price BETWEEN 10000 and 30000) and publisher in('�̻�̵��','���ѹ̵��');
// ��ȭ��ȣ�� null�ΰ��� �̸�, �ּҸ� ���
select name, address from customer where phone is null;
// ��ȭ��ȣ�� null�� �ƴ� �� ���� ���
select * from customer where phone is not null;
