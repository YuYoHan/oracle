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
select * from orders;

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
