create table 극장(
	극장번호 number primary key,
	극장이름 varchar2(20),
	위치 varchar2(20)
);


create table 상영관(
	극장번호 number references 극장(극장번호),
	상영관번호 number check (상영관번호 between 1 and 10),
	영화제목 varchar2(50),
	가격 number check (가격 <= 20000),
	좌석수 number,
	primary key(극장번호,상영관번호)
);


create table 고객(
	고객번호 number primary key,
	이름 varchar2(20),
	주소 varchar2(20)
);

create table 예약(
	극장번호 number,
	상영관번호 number,
	고객번호 number,
	좌석번호 number,
	날짜 date,
	primary key(극장번호,상영관번호,고객번호),
	foreign key(극장번호,상영관번호) references 상영관(극장번호,상영관번호),
	foreign key(고객번호) references 고객(고객번호)
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

// 여기서 테이블을 삭제할 때 부모를 먼저 삭제할 수 없다.
// 자식 테이블을 삭제하고 부모 테이블을 삭제해야 한다.
drop table emp;
drop table dept;

select * from book;
insert into book values(13, '스포츠 의학', null, '한솔의학서적');

// 이미 있는 테이블과 동일한 테이블 만들기
create table newbook2 as select * from book;
select * from newbook2;
drop table newbook2;

create table newbook2 as select * from book where 1=2;

insert into newbook2 select * from book where publisher = '굿스포츠';

select * from customer;
update customer set address = '대한민국 부산' where custId = 5;
rollback;

update customer 
set address = (select address from customer where name='김연아') 
where name = '박세리';

select * from orders;
select * from customer;

delete orders 
where custId = (select custId from customer where name = '박지성');

rollback;

delete orders 
where bookId in (select bookId from book where publisher = '굿스포츠');

// 가상 테이블 사용
select (28) from dual;
select abs(-28) from dual;
select ceil(4.523) from dual;
select floor(4.2321) from dual;
select round(4.823) from dual;
select ceil(-4.523) from dual;
select floor(-4.2321) from dual;
select round(-4.823) from dual;

select round(56.789, 0) from dual; // 정수만 출력
select round(56.789, 1) from dual; // 소숫점 첫번째 출력
select round(56.789, -1) from dual; // 십의자리까지 출력
select round(56.789, -2) from dual; // 백의자리까지 출력

select w.workerId, d.name, w.name, round((salary +comm) *12, -2) 
from worker w
join department d on d.id = w.id
where d.name like '%개발%';

select w.workerId, d.name, w.name, round((salary +nvl(comm,0)) *12, -2) 
from worker w
join department d on d.id = w.id
where d.name like '%개발%';

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

