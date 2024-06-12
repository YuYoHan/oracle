select * from book;
select * from customer;
select * from orders;

insert into book values (11, '신나는 축구', 15000, '코스타미디어');
insert into book values (12, '즐거운 축구교실', 25000, '코스타미디어');

// like 연산자
// 문자열의 어떠한 패턴을 만족하는 데이터를 조회할 때 사용
// 도서명에 축구를 포함하고 있는 모든 도서를 출력
select * from book where bookName like '%축구%';
// 도서명이 축구로 시작하는 도서의 정보를 출력
select * from book where bookName like '축구%';
// 도서명이 축구로 끝나는 도서의 정보를 출력
select * from book where bookName like '%축구';

insert into customer values(6, '김동규', '대한민국 서울', '010-9000-0001');
insert into customer values(7, '김철', '대한민국 대전', '010-9000-0002');
insert into customer values(8, '김민', '대한민국 서울', '010-9000-0003');
delete from customer where custId = 8;
---
// 성씨가 김씨인 모든 고객의 정보를 출력
select * from customer where name like '김%';
// 성씨가 김씨이고 성을 포함하여 이름이 2글자인 고객의 정보를 출력
select * from customer where name like '김_';
// 성씨가 김씨이고 성을 포함하여 이름이 3글자인 고객의 정보를 출력
select * from customer where name like '김__'; 
// 성이 김씨이고 서울에 거주하는 고객의 정보를 출력
select * from customer where name like '김%' and address like '%서울%';

select * from book order by bookId desc;
select * from book order by bookId asc;


// 모든 도서의 정보를 가격순으로 정렬하여 출력
select * from book order by price;
// 축구 관련 도서의 도서명, 가격, 출판사명을 가격이 높은 순으로 출력
select bookName, price, publisher from book where bookName like '%축구%' order by price desc;
// 도서명의 두번째 글자가 '구'이고 가격이 5000원과 50000원 사이인 도서명, 가격, 출판사명 출력
// 단, 출판사순으로 출력하고 출판사가 동일할 때는 가격순으로 출력
select bookName, price, publisher from book
where bookName like '_구%' and price between 5000 and 50000
order by publisher, price;

select name, address from customer where phone = '000-6000-0001';
select * from orders where custId = 1;
select * from orders where bookId in(10, 8, 3) order by orderDate desc;

select bookName, price, publisher from book 
where bookName like '%야구%' order by price desc, bookName;

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

// 서브 쿼리 사용
select  c.custId, c.address, c.phone, b.bookId, b.bookName, o.orderDate, o.salePrice
from orders o
join customer c on c.custId = o.custId
join book b on b.bookId = o.bookId
where o.custId = (select custId from customer where name = '장미란')
order by orderDate desc;
// 서브 쿼리 없이 사용
select c.custId, c.address, c.phone, b.bookId, b.bookName, o.orderDate, o.salePrice
from orders o
join customer c on c.custId = o.custId
join book b on b.bookId = o.bookId
where c.name = '장미란'
order by orderDate desc;

select o.custId, c.name, o.bookId, b.bookName, o.orderDate
from orders o
join book b on b.bookId = o.bookId
join customer c on c.custId = o.custId
where (b.price >= 10000)
    and (b.publisher in('이상미디어','대한미디어')) 
    and (b.bookName LIKE '%축구%' OR b.bookName LIKE '%야구%')
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

insert into department values(1, '기획팀', '종각');
insert into department values(2, '영업팀', '종각');
insert into department values(3, '개발1팀', '판교');
insert into department values(4, '개발2팀', '가산');
insert into department values(5, '개발3팀', '가산');

select * from department;

insert into worker values(1, 1,'2010/01/03', 1000, '변시우', '사장', null);
insert into worker values(2, 1,'2012/08/27', 600, '이동준', '과장', 1);
insert into worker values(3, 1,'2014/07/28', 400, '박성빈', '대리', 2);
insert into worker values(4, 1,'2023/10/10', 200, '임유나', '사원', 2);
insert into worker values(5, 1,'2018/02/17', 600, '홍석영', '사원', 2);

insert into worker values(6, 2,'2013/01/02', 500, '최모래', '과장', 1);
insert into worker values(7, 2,'2014/01/02', 400, '유요한', '대리', 6);
insert into worker values(8, 2,'2020/09/12', 300, '유현진', '사원', 7);
insert into worker values(9, 2,'2020/09/12', 300, '박규희', '사원', 7);

insert into worker values(10, 3,'2012/12/03', 500, '박준수', '과장', 1);
insert into worker values(11, 3,'2020/02/12', 600, '김예은', '대리', 10);
insert into worker values(12, 3,'2024/06/11', 100, '이재원', '사원', 11);
insert into worker values(13, 3,'2020/03/05', 400, '조영흔', '사원', 11);

insert into worker values(14, 4,'2014/10/20', 600, '강동균', '과장', 1);
insert into worker values(15, 4,'2015/01/05', 500, '장동건', '대리', 14);
insert into worker values(16, 4,'2024/04/14', 400, '공희상', '사원', 15);
insert into worker values(17, 4,'2010/01/05', 700, '최가은', '사원', 15);

select w.workerId, w.id, d.name, w.job, w.hiredate, w.salary
from worker w
join department d on d.id = w.id
where d.location = '종각'
order by w.hiredate, workerId;

select d.id, d.name, d.location, w.workerId, w.name, w.hiredate
from worker w
join department d on d.id = w.id
where d.name like '%개발%'
order by d.id, w.workerId;

select d.id, d.name, w.job,w.hiredate, w.salary
from worker w
join department d on d.id = w.id
where w.job in('사원', '대리')
order by w.salary desc, w.hiredate;

drop table worker;

select d.id as "부서번호" , d.name as "부서이름", w.name "사원명", w.hiredate "입사일"
from worker w
join department d on d.id = w.id
where w.hiredate <= '2020/01/01' and w.job = '사원'
order by w.hiredate, w.id;

---
// 집계함수
select sum(price) as "모든 도서의 가격" from book;
// null을 제외하고 계산한다.
select count(bookId) as "모든 도서의 개수" from book;
select avg(price) as "모든 도서의 평균" from book;
select max(price) as "모든 도서의 최고가격" from book;
select min(price) as "모든 도서의 최소가격" from book;

select avg(price) from book where publisher = '이상미디어';

select count(o.custId) "주문 건수", sum(salePrice)"총주문금액" 
from orders o
join customer c on c.custid = o.custId
where c.name = '박지성';

select avg(price), max(price), min(price) 
from book 
where bookName like '%축구%';

select count(workerId) "총직원수", avg(salary) "평균급여" 
from worker w
join department d on d.id = w.id
where d.name = '개발1팀';

select count(custId) "주문한 건수", sum(salePrice) "총 주문금액" 
from orders 
where orderDate between '2024/06/01' and '2024/06/10';

select sum(salary) "총급여"
from worker w
join department d on d.id =w.id
where d.name like '%개발%';

---
// group by
select publisher "출판사", avg(price) "평균금액" from book group by publisher;

