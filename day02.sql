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
select * from book;

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

// ���� ���� ���
select  c.custId, c.address, c.phone, b.bookId, b.bookName, o.orderDate, o.salePrice
from orders o
join customer c on c.custId = o.custId
join book b on b.bookId = o.bookId
where o.custId = (select custId from customer where name = '��̶�')
order by orderDate desc;
// ���� ���� ���� ���
select c.custId, c.address, c.phone, b.bookId, b.bookName, o.orderDate, o.salePrice
from orders o
join customer c on c.custId = o.custId
join book b on b.bookId = o.bookId
where c.name = '��̶�'
order by orderDate desc;

select o.custId, c.name, o.bookId, b.bookName, o.orderDate
from orders o
join book b on b.bookId = o.bookId
join customer c on c.custId = o.custId
where (b.price >= 10000)
    and (b.publisher in('�̻�̵��','���ѹ̵��')) 
    and (b.bookName LIKE '%�౸%' OR b.bookName LIKE '%�߱�%')
order by orderDate desc, b.bookId;

---

create table department(
    id number primary key,
    name varchar2(30),
    location varchar2(100)
);
create table worker(
    workerId number primary key,
    id number REFERENCES department(id),
    hiredate date default sysdate,
    salary number,
    name varchar2(30),
    job varchar2(30),
    mgr number
);

insert into department values(1, '��ȹ��', '����');
insert into department values(2, '������', '����');
insert into department values(3, '����1��', '�Ǳ�');
insert into department values(4, '����2��', '����');
insert into department values(5, '����3��', '����');

select * from department;

insert into worker values(1, 1,'2010/01/03', 1000, '���ÿ�', '����', null);
insert into worker values(2, 1,'2012/08/27', 600, '�̵���', '����', 1);
insert into worker values(3, 1,'2014/07/28', 400, '�ڼ���', '�븮', 2);
insert into worker values(4, 1,'2023/10/10', 200, '������', '���', 2);
insert into worker values(5, 1,'2018/02/17', 600, 'ȫ����', '���', 2);

insert into worker values(6, 2,'2013/01/02', 500, '�ָ�', '����', 1);
insert into worker values(7, 2,'2014/01/02', 400, '������', '�븮', 6);
insert into worker values(8, 2,'2020/09/12', 300, '������', '���', 7);
insert into worker values(9, 2,'2020/09/12', 300, '�ڱ���', '���', 7);

insert into worker values(10, 3,'2012/12/03', 500, '���ؼ�', '����', 1);
insert into worker values(11, 3,'2020/02/12', 600, '�迹��', '�븮', 10);
insert into worker values(12, 3,'2024/06/11', 100, '�����', '���', 11);
insert into worker values(13, 3,'2020/03/05', 400, '������', '���', 11);

insert into worker values(14, 4,'2014/10/20', 600, '������', '����', 1);
insert into worker values(15, 4,'2015/01/05', 500, '�嵿��', '�븮', 14);
insert into worker values(16, 4,'2024/04/14', 400, '�����', '���', 15);
insert into worker values(17, 4,'2010/01/05', 700, '�ְ���', '���', 15);

select w.workerId, w.id, d.name, w.job, w.hiredate, w.salary
from worker w
join department d on d.id = w.id
where d.location = '����'
order by w.hiredate, workerId;

select d.id, d.name, d.location, w.workerId, w.name, w.hiredate
from worker w
join department d on d.id = w.id
where d.name like '%����%'
order by d.id, w.workerId;

select d.id, d.name, w.job,w.hiredate, w.salary
from worker w
join department d on d.id = w.id
where w.job in('���', '�븮')
order by w.salary desc, w.hiredate;

drop table worker;

select d.id as "�μ���ȣ" , d.name as "�μ��̸�", w.name "�����", w.hiredate "�Ի���"
from worker w
join department d on d.id = w.id
where w.hiredate <= '2020/01/01' and w.job = '���'
order by w.hiredate, w.id;

---
// �����Լ�
select sum(price) as "��� ������ ����" from book;
// null�� �����ϰ� ����Ѵ�.
select count(bookId) as "��� ������ ����" from book;
select avg(price) as "��� ������ ���" from book;
select max(price) as "��� ������ �ְ���" from book;
select min(price) as "��� ������ �ּҰ���" from book;

select avg(price) from book where publisher = '�̻�̵��';

select count(o.custId) "�ֹ� �Ǽ�", sum(salePrice)"���ֹ��ݾ�" 
from orders o
join customer c on c.custid = o.custId
where c.name = '������';

select avg(price), max(price), min(price) 
from book 
where bookName like '%�౸%';

select count(workerId) "��������", avg(salary) "��ձ޿�" 
from worker w
join department d on d.id = w.id
where d.name = '����1��';

select count(custId) "�ֹ��� �Ǽ�", sum(salePrice) "�� �ֹ��ݾ�" 
from orders 
where orderDate between '2024/06/01' and '2024/06/10';

select sum(salary) "�ѱ޿�"
from worker w
join department d on d.id =w.id
where d.name like '%����%';

---
// group by
select publisher "���ǻ�", avg(price) "��ձݾ�" from book group by publisher;

