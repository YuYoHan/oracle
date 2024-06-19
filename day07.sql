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

drop table customer;

---
create table ����(
	�����ȣ number primary key,
	�����̸� varchar2(20),
	��ġ varchar2(20)
);


create table �󿵰�(
	�����ȣ number references ����(�����ȣ),
	�󿵰���ȣ number check (�󿵰���ȣ between 1 and 10),
	��ȭ���� varchar2(50),
	���� number check (���� <= 20000),
	�¼��� number,
	primary key(�����ȣ,�󿵰���ȣ)
);


create table ��(
	����ȣ number primary key,
	�̸� varchar2(20),
	�ּ� varchar2(20)
);

create table ����(
	�����ȣ number,
	�󿵰���ȣ number,
	����ȣ number,
	�¼���ȣ number,
	��¥ date,
	primary key(�����ȣ,�󿵰���ȣ,����ȣ),
	foreign key(�����ȣ,�󿵰���ȣ) references �󿵰�(�����ȣ,�󿵰���ȣ),
	foreign key(����ȣ) references ��(����ȣ)
);


insert into ���� values(1, '�Ե�', '���');
insert into ���� values(2, '�ް�', '����');
insert into ���� values(3, '����', '���');

insert into �󿵰� values(1, 1, '����� ��ȭ', 15000,48);
insert into �󿵰� values(3, 1, '���� ��ȭ', 7500,120);
insert into �󿵰� values(3, 2, '��մ� ��ȭ', 8000,110);


insert into �� values(3, 'ȫ�浿', '����');
insert into �� values(4, '��ö��', '���');
insert into �� values(9, '�ڿ���', '����');

insert into ���� values(3,2,3,15,'2014/09/01');
insert into ���� values(3,1,4,16,'2014/09/01');
insert into ���� values(1,1,9,48,'2014/09/01');


column �����ȣ format 9999;
column �����̸� format a10;
column ��ġ format a10;

column �󿵰���ȣ format 9999;
column ��ȭ���� format a10;
column ���� format 999,999;
column �¼��� format 9999;

column ����ȣ format 9999;
column �̸� format a10;
column �ּ� format a10;

column �¼���ȣ format 9999;
column ��¥ format a15;



// 1) ��� ������ �̸��� ��ġ�� ���̽ÿ�.
select �����̸�, ��ġ from ����;
// 2) '���'�� �ִ� ������ ���̽ÿ�.
select * from ���� where ��ġ = '���';
// 3) '���'�� ��� ���� �̸��� ������������ ���̽ÿ�.
select * from �� where �ּ� = '���' order by �̸�;
// 4) ������ 8000�� ������ ��ȭ�� �����ȣ, �󿵰���ȣ, ��ȭ������ ���̽ÿ�.
select �����ȣ, �󿵰���ȣ, ��ȭ���� from �󿵰� where ���� <= 8000;
// 5) ���� ��ġ�� ���� �ּҰ� ���� ���� ���̽ÿ�.
select * from �� where �ּ� in (select ��ġ from ����);
// 6) ������ ���� ��ΰ�?
select count(�����ȣ) from ����;
// 7) �󿵵Ǵ� ��ȭ�� ��� ������ ���ΰ�?
select avg(����) from �󿵰�;
// 8) 2014�� 9�� 1�Ͽ� ��ȭ�� ������ ���� ���� ���ΰ�?
select count(����ȣ) from ���� where ��¥ = '2014/09/01';
// 9) ���� ���忡�� �󿵵� ��ȭ���� ���
select ��ȭ���� from �󿵰� m join ���� c on c.�����ȣ = m.�����ȣ where �����̸� = '����';
// 10) ���� ���忡�� ��ȭ�� �� ���� �̸� ���
select �̸� from ���� r 
join �� c on r.����ȣ = c.����ȣ
join ���� m on m.�����ȣ = r.�����ȣ
where m.�����̸� = '����';
// 11) ���� ������ ��ü ���� ���
//	- �������� ���� �����ȣ�� 3���ΰ� �߿��� �󿵰���ȣ���� ����Ǽ��� ��ȸ
		select �󿵰���ȣ, count(*)
		from ����
		where �����ȣ = 3
		group by �󿵰���ȣ; 
			
	
//	- �������� ���� �����̸��� ���ѱ����� �� �߿��� �󿵰���ȣ���� ����Ǽ��� ��ȸ
		select �󿵰���ȣ, count(*)
		from ����
		where �����ȣ = ( select �����ȣ from ���� where �����̸� = '����' )
		group by �󿵰���ȣ;
	
	
//	- �������� ���� �����̸��� ���ѱ����� �� �߿��� �󿵰���ȣ���� ����Ǽ��� ��ȭ������ ��ȸ
		select �����ȣ, �󿵰���ȣ, 
		count(*) cnt
		from ���� a
		where �����ȣ = ( select �����ȣ from ���� where �����̸� = '����' )
		group by �����ȣ, �󿵰���ȣ;
	
		
  select  sum(cnt* 
	(select ���� from �󿵰� b where a.�����ȣ = b.�����ȣ and a.�󿵰���ȣ = b.�󿵰���ȣ)) sum
	from (select �����ȣ, �󿵰���ȣ, 
		count(*) cnt
		from ���� a
		where �����ȣ = ( select �����ȣ from ���� where �����̸� = '����' )
		group by �����ȣ, �󿵰���ȣ) a;     
// 12) ���庰 �󿵰� �� ���
select �����̸�, count(�󿵰���ȣ) from �󿵰� m
join ���� c on c.�����ȣ = m.�����ȣ
group by �����̸�;
// 13) ��ǿ� �ִ� ������ �󿵰� ���
select * from �󿵰� m
where �����ȣ in (select �����ȣ from ���� where ��ġ ='���');

select �����ȣ, �󿵰���ȣ, count(*)
from ����
group by �����ȣ, �󿵰���ȣ;

---
drop table newbook;
create table newbook(
    bookId number,
    bookName varchar2(20),
    publisher varchar2(20),
    price number
);

desc newbook;
// �߰�
alter table newbook add isbn varchar2(13);
// ����
alter table newbook modify isbn number;
// ����
alter table newbook drop column isbn;

insert into newbook values(1, '��մ� �ڹ�', '�ڽ�Ÿ', 45000);
insert into newbook values(2, '��հ� �ų��� ������', '�ڽ�Ÿ', 45000);

alter table newbook modify bookName varchar2(30);

select * from newbook;

alter table newbook modify bookName varchar2(50) not null;
commit;

// ����
alter table newbook add primary key(bookId);
alter table newbook add check (price >= 1000);

desc user_constraints;
select * from user_constraints;

select constraint_name, constraint_type, table_name, status from user_constraints;

select constraint_name, constraint_type, table_name, status from user_constraints
where table_name = 'NEWBOOK';

// ������ ��Ȱ��ȭ
// alter table ���̺��̸� disable constraint �����;
// ���� Ȱ��ȭ
// alter table ���̺��̸� enable constraint �����;

alter table newbook disable constraint SYS_C008439;
alter table newbook enable constraint SYS_C008439;
select SEARCH_CONDITION, constraint_name, constraint_type, table_name, status 
from user_constraints where table_name = 'NEWBOOK';
