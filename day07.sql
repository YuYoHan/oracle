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

insert into newbook values(1, '재미있는 JPA', '김영한', 35000);
insert into neworders values(1, 1, 1, 35000, sysdate);

select * from neworders;

drop table neworders;
drop table newcustomer;
drop table newBook;

// 도서명과 출판사를 합쳐서 PK 설정
create table newBook(
    bookname varchar2(50),
    publisher VARCHAR2(50),
    price number,
    primary key(bookname, publisher)
);
insert into newBook values ('재밌는 JPA', '김영한', 35000);

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
insert into newcustomer values (1, '유요한', '구로구', '010-0000-0000');
insert into neworders values (1, 1, '재밌는 JPA', '김영한');
// 참조 무결성 : 부모 키가 없다.
insert into neworders values (4, 1, '재밌는 JPA', '김영한');

drop table customer;

---
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


insert into 극장 values(1, '롯데', '잠실');
insert into 극장 values(2, '메가', '강남');
insert into 극장 values(3, '대한', '잠실');

insert into 상영관 values(1, 1, '어려운 영화', 15000,48);
insert into 상영관 values(3, 1, '멋진 영화', 7500,120);
insert into 상영관 values(3, 2, '재밌는 영화', 8000,110);


insert into 고객 values(3, '홍길동', '강남');
insert into 고객 values(4, '김철수', '잠실');
insert into 고객 values(9, '박영희', '강남');

insert into 예약 values(3,2,3,15,'2014/09/01');
insert into 예약 values(3,1,4,16,'2014/09/01');
insert into 예약 values(1,1,9,48,'2014/09/01');


column 극장번호 format 9999;
column 극장이름 format a10;
column 위치 format a10;

column 상영관번호 format 9999;
column 영화제목 format a10;
column 가격 format 999,999;
column 좌석수 format 9999;

column 고객번호 format 9999;
column 이름 format a10;
column 주소 format a10;

column 좌석번호 format 9999;
column 날짜 format a15;



// 1) 모든 극장의 이름과 위치를 보이시오.
select 극장이름, 위치 from 극장;
// 2) '잠실'에 있는 극장을 보이시오.
select * from 극장 where 위치 = '잠실';
// 3) '잠실'에 사는 고객의 이름을 오름차순으로 보이시오.
select * from 고객 where 주소 = '잠실' order by 이름;
// 4) 가격이 8000원 이하인 영화의 극장번호, 상영관번호, 영화제목을 보이시오.
select 극장번호, 상영관번호, 영화제목 from 상영관 where 가격 <= 8000;
// 5) 극장 위치와 고객의 주소가 같은 고객을 보이시오.
select * from 고객 where 주소 in (select 위치 from 극장);
// 6) 극장의 수는 몇개인가?
select count(극장번호) from 극장;
// 7) 상영되는 영화의 평균 가격은 얼마인가?
select avg(가격) from 상영관;
// 8) 2014년 9월 1일에 영화를 관람한 고객의 수는 얼마인가?
select count(고객번호) from 예약 where 날짜 = '2014/09/01';
// 9) 대한 극장에서 상영된 영화제목 출력
select 영화제목 from 상영관 m join 극장 c on c.극장번호 = m.극장번호 where 극장이름 = '대한';
// 10) 대한 극장에서 영화를 본 고객의 이름 출력
select 이름 from 예약 r 
join 고객 c on r.고객번호 = c.고객번호
join 극장 m on m.극장번호 = r.극장번호
where m.극장이름 = '대한';
// 11) 대한 극장의 전체 수입 출력
//	- 예약으로 부터 극장번호가 3번인것 중에서 상영관번호별로 예약건수를 조회
		select 상영관번호, count(*)
		from 예약
		where 극장번호 = 3
		group by 상영관번호; 
			
	
//	- 예약으로 부터 극장이름이 대한극장인 것 중에서 상영관번호별로 예약건수를 조회
		select 상영관번호, count(*)
		from 예약
		where 극장번호 = ( select 극장번호 from 극장 where 극장이름 = '대한' )
		group by 상영관번호;
	
	
//	- 예약으로 부터 극장이름이 대한극장인 것 중에서 상영관번호별로 예약건수와 영화가격을 조회
		select 극장번호, 상영관번호, 
		count(*) cnt
		from 예약 a
		where 극장번호 = ( select 극장번호 from 극장 where 극장이름 = '대한' )
		group by 극장번호, 상영관번호;
	
		
  select  sum(cnt* 
	(select 가격 from 상영관 b where a.극장번호 = b.극장번호 and a.상영관번호 = b.상영관번호)) sum
	from (select 극장번호, 상영관번호, 
		count(*) cnt
		from 예약 a
		where 극장번호 = ( select 극장번호 from 극장 where 극장이름 = '대한' )
		group by 극장번호, 상영관번호) a;     
// 12) 극장별 상영관 수 출력
select 극장이름, count(상영관번호) from 상영관 m
join 극장 c on c.극장번호 = m.극장번호
group by 극장이름;
// 13) 잠실에 있는 극장의 상영관 출력
select * from 상영관 m
where 극장번호 in (select 극장번호 from 극장 where 위치 ='잠실');

select 극장번호, 상영관번호, count(*)
from 예약
group by 극장번호, 상영관번호;

---
drop table newbook;
create table newbook(
    bookId number,
    bookName varchar2(20),
    publisher varchar2(20),
    price number
);

desc newbook;
// 추가
alter table newbook add isbn varchar2(13);
// 수정
alter table newbook modify isbn number;
// 삭제
alter table newbook drop column isbn;

insert into newbook values(1, '재밌는 자바', '코스타', 45000);
insert into newbook values(2, '재밌고 신나는 스프링', '코스타', 45000);

alter table newbook modify bookName varchar2(30);

select * from newbook;

alter table newbook modify bookName varchar2(50) not null;
commit;

// 연습
alter table newbook add primary key(bookId);
alter table newbook add check (price >= 1000);

desc user_constraints;
select * from user_constraints;

select constraint_name, constraint_type, table_name, status from user_constraints;

select constraint_name, constraint_type, table_name, status from user_constraints
where table_name = 'NEWBOOK';

// 제약을 비활성화
// alter table 테이블이름 disable constraint 제약명;
// 제약 활성화
// alter table 테이블이름 enable constraint 제약명;

alter table newbook disable constraint SYS_C008439;
alter table newbook enable constraint SYS_C008439;
select SEARCH_CONDITION, constraint_name, constraint_type, table_name, status 
from user_constraints where table_name = 'NEWBOOK';
