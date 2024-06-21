select months_between(sysdate, to_date('2002/10/10')) from dual;

select * from worker;

select 
    w.workerId,
    w.name,
    d.name,
    w.hiredate,
    round(months_between(sysdate, to_date(hiredate)),0) �ٹ�����,
    rpad(substr(w.jumin,1,8), 14, '*') �ֹι�ȣ
from worker w
join department d on d.id = w.id
where round(months_between(sysdate, to_date(hiredate)),0) >= 60 and w.jumin is not null
order by �ٹ����� desc, w.name;

create table test(
    title varchar2(20),
    cnt number
);

select max(cnt) from test; // null    
select min(cnt) from test; // null   
select sum(cnt) from test; // null   
select avg(cnt) from test; // null
select count(cnt) from test; // 0

drop table test;

create table board(
    no number primary key,
    title varchar2(50),
    writer varchar2(20),
    content varchar2(3000),
    regdate date
);

create sequence seq_board start with 1 increment by 1;
insert into board values(seq_board.nextval, '�ݿ���', '���ּ�', '�ݿ���', sysdate);
insert into board values(seq_board.nextval, '������Ʈ', '����', '������', sysdate);
insert into board values(seq_board.nextval, '���̺�', '������', 'wow', sysdate);
insert into board values(seq_board.nextval, 'check', 'KOSTA', '������', sysdate);

select * from board;
drop table seq_board;

create sequence seq_board;

select rownum, w.workerId, w.name
from worker w
join department d on d.id = w.id
where d.name like '%����%';

select rownum, bookname, price
from orders o
join book b on b.bookid = o.bookid
join customer c on c.custid = o.custid
where c.name = '������' and rownum <= 2;

select 
    rowname,
    bookname,
    price
from orders
where orders.bookid in 
(select bookid from orders where custid = 
    (select custid from customer where name ='������'));

select * from book;

// ���� ����
// �� �� �� �� �� �� ��
select rownum, bookid, bookname, price, publisher
from (select * from book order by price desc)
where rownum <= 3 and price is not null;