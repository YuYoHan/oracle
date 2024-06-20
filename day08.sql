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


---
create table dept(
    dno number primary key,
    dname varchar2(20),
    dloc varchar2(20)
);

create table emp(
    eno number primary key,
    ename varchar2(20),
    dno NUMBER references dept(dno)
);

// ���⼭ ���̺��� ������ �� �θ� ���� ������ �� ����.
// �ڽ� ���̺��� �����ϰ� �θ� ���̺��� �����ؾ� �Ѵ�.
drop table emp;
drop table dept;

select * from book;
insert into book values(13, '������ ����', null, '�Ѽ����м���');

// �̹� �ִ� ���̺�� ������ ���̺� �����
create table newbook2 as select * from book;
select * from newbook2;
drop table newbook2;

create table newbook2 as select * from book where 1=2;

insert into newbook2 select * from book where publisher = '�½�����';

select * from customer;
update customer set address = '���ѹα� �λ�' where custId = 5;
rollback;

update customer 
set address = (select address from customer where name='�迬��') 
where name = '�ڼ���';

select * from orders;
select * from customer;

delete orders 
where custId = (select custId from customer where name = '������');

rollback;

delete orders 
where bookId in (select bookId from book where publisher = '�½�����');

// ���� ���̺� ���
select (28) from dual;
select abs(-28) from dual;
select ceil(4.523) from dual;
select floor(4.2321) from dual;
select round(4.823) from dual;
select ceil(-4.523) from dual;
select floor(-4.2321) from dual;
select round(-4.823) from dual;

select round(56.789, 0) from dual; // ������ ���
select round(56.789, 1) from dual; // �Ҽ��� ù��° ���
select round(56.789, -1) from dual; // �����ڸ����� ���
select round(56.789, -2) from dual; // �����ڸ����� ���

select w.workerId, d.name, w.name, round((salary +comm) *12, -2) 
from worker w
join department d on d.id = w.id
where d.name like '%����%';

select w.workerId, d.name, w.name, round((salary +nvl(comm,0)) *12, -2) 
from worker w
join department d on d.id = w.id
where d.name like '%����%';

delete customer where custId >= 6;

select * from customer;

insert into customer values(6, 'Tiger', null, null);
insert into customer values(7, 'tiger', null, null);
insert into customer values(8, 'TIGER', null, null);

select lower(name) from customer;
select upper(name) from customer;

select count(name) from customer where lower(name) = 'tiger';


insert into customer values(9, '  tiger', null, null);
insert into customer values(10, '  tiger   ', null, null);
insert into customer values(11, 'TIGER   ', null, null);

select * from customer where lower(trim(name)) = 'tiger';

