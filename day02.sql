select * from book;
select * from customer;
select * from orders;

insert into book values (11, '�ų��� �౸', 15000, '�ڽ�Ÿ�̵��');
insert into book values (12, '��ſ� �౸����', 25000, '�ڽ�Ÿ�̵��');

// like ������
// ���ڿ��� ��� ������ �����ϴ� �����͸� ��ȸ�� �� ���
// ������ �౸�� �����ϰ� �ִ� ��� ������ ���
select * from book where bookName like '%�౸%';
// �������� �౸�� �����ϴ� ������ ������ ���
select * from book where bookName like '�౸%';
// �������� �౸�� ������ ������ ������ ���
select * from book where bookName like '%�౸';

insert into customer values(6, '�赿��', '���ѹα� ����', '010-9000-0001');
insert into customer values(7, '��ö', '���ѹα� ����', '010-9000-0002');
insert into customer values(8, '���', '���ѹα� ����', '010-9000-0003');
delete from customer where custId = 8;
---
// ������ �达�� ��� ���� ������ ���
select * from customer where name like '��%';
// ������ �达�̰� ���� �����Ͽ� �̸��� 2������ ���� ������ ���
select * from customer where name like '��_';
// ������ �达�̰� ���� �����Ͽ� �̸��� 3������ ���� ������ ���
select * from customer where name like '��__'; 
// ���� �达�̰� ���￡ �����ϴ� ���� ������ ���
select * from customer where name like '��%' and address like '%����%';

select * from book order by bookId desc;
select * from book order by bookId asc;


// ��� ������ ������ ���ݼ����� �����Ͽ� ���
select * from book order by price;
// �౸ ���� ������ ������, ����, ���ǻ���� ������ ���� ������ ���
select bookName, price, publisher from book where bookName like '%�౸%' order by price desc;
// �������� �ι�° ���ڰ� '��'�̰� ������ 5000���� 50000�� ������ ������, ����, ���ǻ�� ���
// ��, ���ǻ������ ����ϰ� ���ǻ簡 ������ ���� ���ݼ����� ���
select bookName, price, publisher from book
where bookName like '_��%' and price between 5000 and 50000
order by publisher, price;

select name, address from customer where phone = '000-6000-0001';
select * from orders where custId = 1;
select * from orders where bookId in(10, 8, 3) order by orderDate desc;

select bookName, price, publisher from book 
where bookName like '%�߱�%' order by price desc, bookName;

select * from orders 
where (salePrice >= 20000) and (orderDate between '2024/06/01' and '2024/06/10')
order by orderDate desc, salePrice desc;

---
// join
select * from orders;

select name from customer c, orders o
where c.custId = o.custId and bookId = 10;

SELECT c.name 
FROM orders o
JOIN customer c ON o.custId = c.custId
WHERE o.bookid = 10;

select b.bookName 
from orders o
join book b on o.bookId = b.bookId
where custId =1;

select b.bookId, b.bookName, o.salePrice, o.orderDate, b.publisher
from orders o
join book b on b.bookId = o.bookId
where custId = 1;
