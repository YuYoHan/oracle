desc worker;

// �÷��߰�
alter table worker add comm number;
desc worker;

ALTER TABLE worker DROP COLUMN comm;
select * from worker;


update worker set comm=80 where workerId=1;
update worker set comm = 50 where workerId = 2 ;
update worker set comm = 70 where workerId = 3;
update worker set comm = 100 where workerId = 4;
update worker set comm = 70 where workerId = 5;
update worker set comm = 70 where workerId = 6;
update worker set comm = 90 where workerId= 7;
update worker set comm = 70 where workerId=8;
update worker set comm = 77 where workerId=9;
update worker set comm = 50 where workerId = 10;
update worker set comm = 60 where workerId = 11;
update worker set comm=60 where workerId=12;
update worker set comm = 100 where workerId = 13;
update worker set comm = 110 where workerId = 14 ;
update worker set comm = 150 where workerId = 15 ;
update worker set comm = 200 where workerId = 16 ;
UPDATE worker SET comm = 99 WHERE workerId = 17;

insert into worker values(18, sysdate, 500, 'ȫ�浿','���', 10,3, null);
----
// ����
select name, job from worker;

select w.name, w.salary
from worker w
join department d on d.id = w.id
where d.id = 10;

select name, salary from worker w
join department d on d.id = w.id
where d.name = '��ȹ��';

select w.name, d.id 
from worker w
join department d on d.id = w.id
where w.name like '��%';

select max(salary), min(salary), sum(salary), avg(salary) from worker;

select job, count(job)
from worker
group by job having job = job;

select max(salary)- min(salary) 
from worker;

select count(workerId), sum(salary), avg(salary)
from worker w
join department d on d.id = w.id
where d.id = 10;

select count(workerId), sum(salary), avg(salary)
from worker w
join department d on d.id = w.id
where d.name = '����';

select workerId
from (select workerId, avg(salary) avg from worker group by workerId)
where workerId = (select max(avg(salary))from worker group by workerId);

select id from department where workerId not in(select disinct workerId from worker);
select job, count(workerId)
from (select workerId from worker where job = job)
group by job having count(workerId) >= 2;
select name from worker where workerId between 1002 and 1010;
select w.name, d.id from worker w join department d on d.id = w.id;
select w.name, m.name from woreker w join worker m on w.mgr = m.id;
select name from worker where salary > (select salary from worker where name = '�ڱ���');
select name from worker w join department d on d.id = w.id where d.location = (
select d.location from worker w join department d on d.id = w.id where w.name = '�ڱ���'); 

---
create table newBook(
    bookid number ,
    bookname varchar2(20),
    publisher varchar2(20),
    price number
);
desc newBook;

// ������ �߰�
insert into newBook values(1, '����ִ� �ڹ�', '�ڽ�Ÿ�̵��', 30000);
insert into newBook values(2, '�ų��� �ڹ�', null, null);
insert into newBook (bookname, bookid, price, publisher) 
values('�ų��� ����Ŭ', 3, 35000, '�Ѻ��̵��');
insert into newBook(bookid, bookname) values(4, '�ų��� ������');
select * from newBook;

// å��ȣ�� ���ݸ� ���� ���ڵ带 �߰�
insert into newBook (bookid, price) values(5, 30000);
insert into newBook values(6, null, null, 20000);

// ���̺� ����
drop table newBook;
desc newBook;

create table newBook(
    bookid number not null,
    bookname varchar2(20) not null,
    publisher varchar2(20),
    price number
);
// ORA-01400 ���� �߻� 
// ���� not null�ȿ� null�� �������� �ؼ� �߻��ϴ� ����
insert into newBook values(1, null, '�ڽ�Ÿ�̵��', 30000);
insert into newBook values(null, '�ų��� �ڹ�', null, null);

// unique ����
drop table newBook;
create table newBook(
    bookid number unique,
    bookname varchar2(20) not null,
    publisher varchar2(20),
    price number
);
insert into newBook values(1, '��մ� �ڹ�', '�ڽ�Ÿ�̵��', 30000);
// ORA-00001: ���Ἲ ���� ����(C##MADANG.SYS_C008366)�� ����˴ϴ�
// bookid�� ���ϰ��ε� �ߺ��� ���� �־ ���� �߻�
insert into newBook values(1, '�ų��� �ڹ�', null, null);

create table newBook(
    bookid number primary key,
    bookname varchar2(20) not null,
    publisher varchar2(20),
    price number
);
insert into newBook values(1, '��մ� �ڹ�', '�ڽ�Ÿ�̵��', 30000);
// ORA-00001: ���Ἲ ���� ����(C##MADANG.SYS_C008366)�� ����˴ϴ�
insert into newBook values(1, '��մ� ����', '�ڽ�Ÿ�̵��', 30000);
// ORA-01400 ���� �߻� 
insert into newBook values(null, '��մ� �ڹ�', '�ڽ�Ÿ�̵��', 30000);
drop table newBook;

create table newBook(
    bookid number primary key,
    bookname varchar2(20) not null,
    publisher varchar2(20) default '�ڽ�Ÿ�̵��',
    price number
);
insert into newBook values(1, '����ִ� �ڹ�', '�Ѻ��̵��', 5000);
insert into newBook values(2, '�ų��� �ڹ�', '�ڽ�Ÿ�̵��', 5000);
insert into newBook (bookid, bookname) values(3, '����ִ� �ڹ�');
select * from newBook;

create table newBook(
    bookid number primary key,
    bookname varchar2(20) not null,
    publisher varchar2(20) default '�ڽ�Ÿ�̵��',
    price number check (price >= 1000)
);
insert into newBook values(1, '����ִ� �ڹ�', '�Ѻ��̵��', 5000);
// ORA-02290: üũ ��������(C##MADANG.SYS_C008384)�� ����Ǿ����ϴ�
insert into newBook values(2, '����ִ� �ڹ�', '�Ѻ��̵��', 900);

create table newBook(
    bookid number primary key,
    bookname varchar2(20) not null,
    publisher varchar2(20) check (publisher in('�Ｚ��', '�ڽ�Ÿ�̵��', '�Ѻ��̵��')),
    price number check (price between 10000 and 50000)
);
insert into newBook values(1, '����ִ� �ڹ�', '�Ѻ��̵��', 10000);
// ORA-02290: üũ ��������(C##MADANG.SYS_C008387)�� ����Ǿ����ϴ�
insert into newBook values(2, '����ִ� �ڹ�', '���ѹ̵��', 10000);
insert into newBook values(3, '����ִ� �ڹ�', '�Ｚ��', 10000);
insert into newBook values(4, '�ų��� �ڹ�', '�ڽ�Ÿ�̵��', 50000);

create table newBook(
    bookid number primary key,
    bookname varchar2(20) not null,
    publisher VARCHAR2(20) DEFAULT '�Ｚ��' CHECK (publisher IN ('�Ｚ��', '�ڽ�Ÿ�̵��', '�Ѻ��̵��')),
    price number not null check (price between 10000 and 50000)
);

insert into newBook values(1, '����ִ� �ڹ�', '�Ѻ��̵��', 10000);
insert into newBook (bookid, bookname, price) values(2, '����ִ� �ڹ�', 40000);
select * from newBook;

drop table newBook;

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

desc neworders;
drop table neworders;
drop table newcustomer;
drop table newBook;

select bookId, bookName, publisher, price from book;
insert into newbook select bookId, bookName, publisher, price from book;
select * from newbook;

insert into newcustomer select custId, name, address, phone from customer;
select * from newcustomer;

insert into neworders select * from orders;
select * from neworders;

insert into neworders values (13, 3, 9, 40000, sysdate);
// ORA-02291: ���Ἲ ��������(C##MADANG.SYS_C008405)�� ����Ǿ����ϴ�- �θ� Ű�� �����ϴ�
insert into neworders values (13, 60, 9, 40000, sysdate);






