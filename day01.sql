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
    orderDate DATE
);

desc book;
desc orders;

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
