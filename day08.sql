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
select * from book where length(bookname) >= 7;
select lengthb('ȫ') from dual;
select replace('����ִ� �ڹ�', '����ִ�', '�ų���') ����Ȱ� from dual;

select bookId, replace(bookname, '�߱�', '��')������, nvl(price,0) from book;

alter table worker add jumin varchar2(14);
alter table worker add email varchar2(50);

desc worker;
select * from worker;

update worker set jumin = '901010-1234567', email ='edj19877@gmail.com' where name = '�̵���';
update worker set jumin='980728-1234567', email = 'goodstar7369@naver.com'  where name = '�ڼ���';
update worker set jumin ='021010-4123456', email = 'dladbsk674@naver.com' where name = '������';
update worker set jumin = '970217-1111111', email = 'ghdtjrdud38@naver.conm' where name = 'ȫ����';
update worker set jumin = '920511-1234566', email = 'zxzz8014@naver.com' where workerId = 7;
update worker set email='principle950@naver.com', jumin='950830-2000000' where name = '�ָ�';
update worker set email='uhyeonjin0619@gmail.com', jumin='960619-1234567' where name='������';
update worker set jumin = '971223-2000000', email = 'qordpsem@gmail.com' where name = 'ȫ����';
update worker set jumin='941104-1234567', email='pjsu94@naver.com' where name = '���ؼ�';
update worker set jumin='970128-1111111', email='dlwodnjs0128@naver.com' where name= '�����';
update worker set jumin = '930304-1023412' , email = 'whdudgms123@naver.com' where name= '������';
UPDATE worker SET jumin = '980105-1212331', email = '85356271a@gmail.com'
WHERE name = '�嵿��';
UPDATE worker SET JUMIN = '010205-3123456', EMAIL = 'rhdgmltkd88@gmail.com' WHERE name = '�����';

// �������� �ٹ��ϴ� �����ȣ
select workerId
from worker
where id in (select id from department where name like '%����%');

// �������� �ٹ��ϴ� ���� �����ȣ
select workerId
from worker
where id in (select id from department where name like '%����%')
and substr(jumin,8,1) in (1,3);

// �������� �ٹ��ϴ� ���� �����ȣ, �̸�, �󿩱�, �ֹι�ȣ
select 
    workerId, 
    name, 
    (w.salary + NVL((comm, 0)) * 12) * 1.5 �󿩱�,
    name,
    (select name from worker m where w.mgr = m.id),
    jumin
from worker w
where id in (select * from department where name like '%����%') 
and substr(jumin,8,1) in (1,3);


select * from ����;

select workerId, substr(jumin,1,8) jumin, substr(email,1, instr(email, '@') -1) id 
from worker where jumin is not null;

select lpad('hello', 10, '*') from dual;

select 
    w.workerId �����ȣ, 
    w.name ����̸�,
    m.name �����ڸ�,
    lpad(round((w.salary + NVL(w.comm, 0) * 12 * 2.0), -1), 10, '0') �󿩱�,
    rpad(substr(w.jumin,1,8), 14, '*') �ֹι�ȣ,
    substr(w.email, 1, instr(w.email, '@') -1) ���̵�,
    w.hiredate �Ի���
from worker w
join worker m on w.mgr = m.id
where substr(w.jumin,8,1) in (1,3) and w.hiredate < '2021/01/01';

select to_char(sysdate, 'yy') from dual;
select to_char(sysdate, 'yyyy/mm/dd/hh/mi/ss') from dual;
select to_char(hiredate, 'yyyy') from worker;

select 
    w.name �̸�,
    m.name �������̸�,
    d.name �μ���,
    w.hiredate �Ի���,
    rpad(substr(w.jumin, 1, 8), 14, '*') �ֹι�ȣ
from worker w
join worker m on m.workerId = w.mgr
join department d on d.id = w.id
where to_char(w.hiredate, 'yyyy') = '2020';

select * from worker where to_char(hiredate, 'yyyy') = '2020';

select * from worker where to_char(hiredate, 'mm') = '06'; 

select substr(jumin, 1, 6) from worker;
select to_date(substr(jumin, 1, 6), 'yymmdd')from worker;
select to_char(sysdate, 'yyyy')- to_char(to_date('021010', 'yymmdd'), 'yyyy') from dual;


select
    workerId,
    name,
    jumin,
    to_char(sysdate, 'yyyy') - to_char(to_date(substr(jumin, 1, 6) , 'yymmdd'), 'yyyy') age
from worker where jumin is not null;

// �ֹι�ȣ�� ���� 2�ڸ��� �߶����
select substr(jumin, 1, 2) from worker where jumin is not null;

// �߶�� �ֹι�ȣ �� 2�ڸ��� 19���ڸ� ����
select concat('19',substr(jumin, 1, 2)) from worker where jumin is not null;

// ���� ��¥ �������� ��������� ���� ����
select to_char(sysdate, 'yyyy') 
    - concat('19',substr(jumin, 1, 2)) from worker where jumin is not null;
    
// 2000�� �� ���� ����� ����ϱ�
select 
    workerId,
    name,
    jumin,
    to_char(sysdate, 'yyyy') 
    - case
            when substr(jumin, 8, 1) in ('1', '2') then  concat('19',substr(jumin, 1, 2))
            when substr(jumin, 8, 1) in ('3', '4') then  concat('20',substr(jumin, 1, 2))
    end
    as age
from worker where jumin is not null;

// ���̰� 28�� �̻��� ��� ������ ����
select workerId from (
    select 
    workerId,
    to_char(sysdate, 'yyyy') 
    - case
            when substr(jumin, 8, 1) in ('1', '2') then  concat('19',substr(jumin, 1, 2))
            when substr(jumin, 8, 1) in ('3', '4') then  concat('20',substr(jumin, 1, 2))
    end
    as age
from worker where jumin is not null
)
where  age >= 27;

// ���̰� 27�� �̻��� ��� ������ ����
select * from worker
where workerId in (
    select workerId 
    from (
        select 
            workerId,
            to_char(sysdate, 'yyyy') 
            - case
            when substr(jumin, 8, 1) in ('1', '2') then  concat('19',substr(jumin, 1, 2))
            when substr(jumin, 8, 1) in ('3', '4') then  concat('20',substr(jumin, 1, 2))
            end
            as age
        from worker where jumin is not null
        )
    where  age >= 27
);

select 
    w.workerId,
    w.name,
    m.name,
    w.hiredate,
    
