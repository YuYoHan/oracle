create table book(
    bookId number PRIMARY KEY,
    bookName varchar2(50),
    price number,
    publisher varchar2(50)
);

drop table book;
select * from book;

create table customer(
    custId number PRIMARY KEY,
    name varchar2(20),
    address varchar2(100),
    phone varchar2(100)
);

create table orders(
    orderId number primary key,
    custId number REFERENCES customer(custId),
    bookId number REFERENCES book(bookId),
    salePrice number,
    orderDate DATE default sysdate
);

desc book;
desc orders;
drop table orders;

insert into book values(1, '축구의 역사', 7000, '굿스포츠');
commit;
insert into book(bookId, bookName, price, publisher) 
    values(2, '축구아는 여자', 9000, '나무수');
    
insert into book(bookId, bookName, price, publisher) 
    values(3, '축구의 이해', 22000, '대한미디어');
insert into book(bookId, bookName, price, publisher) 
    values(4, '골프 바이블', 13000, '대한미디어');
insert into book(bookId, bookName, price, publisher) 
    values(5, '피겨 교본', 8000, '굿스포츠');
insert into book(bookId, bookName, price, publisher) 
    values(6, '역도 단계별 기술', 6000, '굿스포츠');
insert into book(bookId, bookName, price, publisher) 
    values(7, '야구의 추억', 20000, '이상미디어');
insert into book(bookId, bookName, price, publisher) 
    values(8, '야구를 부탁해', 3000, '이상미디어');
insert into book(bookId, bookName, price, publisher) 
    values(9, '올림픽 이야기', 7500, '삼성당');
insert into book(bookId, bookName, price, publisher) 
    values(10, '올림픽 챔피언', 10000, 'Pearson');
    
commit;

// 보기 좋게 정렬
column bookId format 9999;
column bookName format a20;
column price format 999,999;
column publisher format a20;
select * from book;

// 한글은 한글자 표현하기 위해서 varchar2(3)
insert into customer values(1, '박지성', '영국 맨체스타','010-5000-0001');
insert into customer values(2, '김연아', '대한민국 서울','010-5000-0002');
insert into customer values(3, '장미란', '대한민국 강원도','010-5000-0003');
insert into customer values(4, '추신수', '미국 클리블랜드','010-5000-0004');
insert into customer values(5, '박세리', '대한민국 대전', null);
select * from customer;

// 테이블 수정
alter table customer modify address varchar2(99);
// 데이터 수정
update customer set phone = '010-5000-0005' where custId = 5;
select * from customer where custId = 5;

insert into orders (orderId, custId, bookId, saleprice) values(1, 2, 5, 8000);
select * from orders;
SELECT b.bookName, c.name
FROM book b
JOIN customer c ON b.bookId = 2 AND c.custId = 5;

insert into orders (orderId, custId, bookId, saleprice, orderDate) 
values(2, 1, 3, 8000, '2024/06/07');
insert into orders (orderId, custId, bookId, saleprice, orderDate) 
values(3, 2, 5, 6000, '2024/06/01');
insert into orders (orderId, custId, bookId, saleprice) 
values(4, 3, 6, 20000);
insert into orders (orderId, custId, bookId, saleprice) 
values(5, 4, 7, 12000);
insert into orders (orderId, custId, bookId, saleprice, orderDate) 
values(6, 1, 2, 13000, '2024/06/05');
insert into orders (orderId, custId, bookId, saleprice, orderDate) 
values(7, 4, 8, 12000, '2024/05/05');
insert into orders (orderId, custId, bookId, saleprice) 
values(8, 3, 10, 7000);
insert into orders (orderId, custId, bookId, saleprice) 
values(9, 2, 10, 13000);
insert into orders (orderId, custId, bookId, saleprice, orderDate) 
values(10, 3, 8, 7000, '2024/06/06');
insert into orders (orderId, custId, bookId, saleprice, orderDate) 
values(11, 3, 8, 9000, '2024/06/10');
select * from orders;

// 고객들의 주소
select address from customer;
// 김연아 고객의 주소
select address from customer where name = '김연아';
// 대한미디어에서 출간하는 도서의 도서명과 가격을 조회
select bookName, price from book where publisher = '대한미디어';
// 대한미디어에서 출간하는 모든 도서의 도서번호, 도서명, 가격, 출판사 조회
select * from book where publisher = '대한미디어';
// 모든 출판사 목록을 출력
select publisher from book;
// 중복제거하고 출력
select DISTINCT publisher from book;

// 연습
// 가격이 20000원 이상인 도서의 목록을 출력
select * from book where price >= 20000;
// 출판사가 굿스포츠가 아닌 모든 도서 목록을 출력
select * from book where publisher <> '국스포츠';
// 2024년 6월 10일 주문한 도서번호와 고객번호를 출력
select bookId, custId from orders where orderDate = '2024/06/10';
// 이상미디어에서 출간하는 도서중에 가격이 20000원 이상인 도서번호, 도서명 출력
select bookId, bookName from book where price >= 20000 and publisher = '이상미디어';
// 이상미디어나 대한미디어에서 출간하는 도서의 도서번호, 도서명, 출판사명을 출력
select bookId, bookName, publisher from book 
where publisher = '이상미디어' or publisher = '대한미디어';
select bookId, bookName, publisher from book 
where publisher in ('이상미디어', '대한미디어');

// 이상미디어도 아니고 대한미디어도 아닌 출판사의 도서번호, 도서명, 출판사명 출력
select bookId, bookName, publisher from book where publisher not in ('이상미디어', '대한미디어');
// 이상미디어나 대한미디어에서 출판하는 도서중 가격이 20000이상인 도서번호, 도서명, 출판사명 출력
select bookId, bookName, publisher from book 
where publisher in ('이상미디어','대한미디어') and price >= 20000;
// 가격이 10000원 이상 20000원 이하인 도서의 도서번호, 출판사명, 가격을 출력
select bookId, publisher, price from book where price BETWEEN 10000 and 20000;
// 대한미디어나 이상미디어에서 출판하는 도서중 가격이 10000원 이상 30000원 이하인 도서 정보 출력
select * from book where (price BETWEEN 10000 and 30000) and publisher in('이상미디어','대한미디어');
// 전화번호가 null인고객의 이름, 주소를 출력
select name, address from customer where phone is null;
// 전화번호가 null이 아닌 고객 정보 출력
select * from customer where phone is not null;
