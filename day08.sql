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
select * from book where length(bookname) >= 7;
select lengthb('홍') from dual;
select replace('재미있는 자바', '재미있는', '신나는') 변경된값 from dual;

select bookId, replace(bookname, '야구', '농구')도서명, nvl(price,0) from book;

alter table worker add jumin varchar2(14);
alter table worker add email varchar2(50);

desc worker;
select * from worker;

update worker set jumin = '901010-1234567', email ='edj19877@gmail.com' where name = '이동준';
update worker set jumin='980728-1234567', email = 'goodstar7369@naver.com'  where name = '박성빈';
update worker set jumin ='021010-4123456', email = 'dladbsk674@naver.com' where name = '임유나';
update worker set jumin = '970217-1111111', email = 'ghdtjrdud38@naver.conm' where name = '홍석영';
update worker set jumin = '920511-1234566', email = 'zxzz8014@naver.com' where workerId = 7;
update worker set email='principle950@naver.com', jumin='950830-2000000' where name = '최모래';
update worker set email='uhyeonjin0619@gmail.com', jumin='960619-1234567' where name='유현진';
update worker set jumin = '971223-2000000', email = 'qordpsem@gmail.com' where name = '홍석영';
update worker set jumin='941104-1234567', email='pjsu94@naver.com' where name = '박준수';
update worker set jumin='970128-1111111', email='dlwodnjs0128@naver.com' where name= '이재원';
update worker set jumin = '930304-1023412' , email = 'whdudgms123@naver.com' where name= '조영흔';
UPDATE worker SET jumin = '980105-1212331', email = '85356271a@gmail.com'
WHERE name = '장동건';
UPDATE worker SET JUMIN = '010205-3123456', EMAIL = 'rhdgmltkd88@gmail.com' WHERE name = '공희상';

// 개발팀에 근무하는 사원번호
select workerId
from worker
where id in (select id from department where name like '%개발%');

// 개발팀에 근무하는 남자 사원번호
select workerId
from worker
where id in (select id from department where name like '%개발%')
and substr(jumin,8,1) in (1,3);

// 개발팀에 근무하는 남자 사원번호, 이름, 상여금, 주민번호
select 
    workerId, 
    name, 
    (w.salary + NVL((comm, 0)) * 12) * 1.5 상여금,
    name,
    (select name from worker m where w.mgr = m.id),
    jumin
from worker w
where id in (select * from department where name like '%개발%') 
and substr(jumin,8,1) in (1,3);


select * from 예약;

select workerId, substr(jumin,1,8) jumin, substr(email,1, instr(email, '@') -1) id 
from worker where jumin is not null;

select lpad('hello', 10, '*') from dual;

select 
    w.workerId 사원번호, 
    w.name 사원이름,
    m.name 관리자명,
    lpad(round((w.salary + NVL(w.comm, 0) * 12 * 2.0), -1), 10, '0') 상여금,
    rpad(substr(w.jumin,1,8), 14, '*') 주민번호,
    substr(w.email, 1, instr(w.email, '@') -1) 아이디,
    w.hiredate 입사일
from worker w
join worker m on w.mgr = m.id
where substr(w.jumin,8,1) in (1,3) and w.hiredate < '2021/01/01';

select to_char(sysdate, 'yy') from dual;
select to_char(sysdate, 'yyyy/mm/dd/hh/mi/ss') from dual;
select to_char(hiredate, 'yyyy') from worker;

select 
    w.name 이름,
    m.name 관리자이름,
    d.name 부서명,
    w.hiredate 입사일,
    rpad(substr(w.jumin, 1, 8), 14, '*') 주민번호
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

// 주민번호의 앞의 2자리만 잘라오기
select substr(jumin, 1, 2) from worker where jumin is not null;

// 잘라온 주민번호 앞 2자리에 19글자를 연결
select concat('19',substr(jumin, 1, 2)) from worker where jumin is not null;

// 오늘 날짜 연도에서 출생연도를 빼면 나이
select to_char(sysdate, 'yyyy') 
    - concat('19',substr(jumin, 1, 2)) from worker where jumin is not null;
    
// 2000년 생 이후 출생자 고려하기
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

// 나이가 28살 이상인 모든 직원의 정보
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

// 나이가 27살 이상인 모든 직원의 정보
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
    
