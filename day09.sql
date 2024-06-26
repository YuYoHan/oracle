select months_between(sysdate, to_date('2002/10/10')) from dual;

select * from worker;

select 
    w.workerId,
    w.name,
    d.name,
    w.hiredate,
    round(months_between(sysdate, to_date(hiredate)),0) 근무개월,
    rpad(substr(w.jumin,1,8), 14, '*') 주민번호
from worker w
join department d on d.id = w.id
where round(months_between(sysdate, to_date(hiredate)),0) >= 60 and w.jumin is not null
order by 근무개월 desc, w.name;

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
insert into board values(seq_board.nextval, '금요일', '김주선', '금요일', sysdate);
insert into board values(seq_board.nextval, '프로젝트', '영수', '잘하자', sysdate);
insert into board values(seq_board.nextval, '아이브', '안유진', 'wow', sysdate);
insert into board values(seq_board.nextval, 'check', 'KOSTA', '힘내자', sysdate);

select * from board;
drop table seq_board;

create sequence seq_board;

select rownum, w.workerId, w.name
from worker w
join department d on d.id = w.id
where d.name like '%개발%';

select rownum, bookname, price
from orders o
join book b on b.bookid = o.bookid
join customer c on c.custid = o.custid
where c.name = '박지성' and rownum <= 2;

select 
    rowname,
    bookname,
    price
from orders
where orders.bookid in 
(select bookid from orders where custid = 
    (select custid from customer where name ='박지성'));

select * from book;

// 실행 순서
// 나 → 다 → 가 → 라
select rownum, bookid, bookname, price, publisher
from (select * from book order by price desc)
where rownum <= 3 and price is not null;

// 조회한 결과에 행본호인 rownum을 붙여서
// 순차적으로 가져올 때는 잘되지만
// 중간에 있는 데이터를 가져올 때는 안된다.
select rownum, bookid, bookname, price, publisher
from (select * from book order by price desc)
where (rownum between 3 and 5) and (price is not null);

// 가능하게 하려면 행번호 붙인 것을 다시 from 절에 서브쿼리로 하면 가능해진다.
select bookid, bookname, price, publisher
from (select rownum n, bookid, bookname, price, publisher
from (select * from book where price is not null order by price desc)) 
where n between 3 and 4;

// 도서번호별로 판매량을 출력
// ↓ A
select bookid, count(*) cnt
from orders
group by bookid
order by cnt desc;

// A의 결과에 행번호를 붙여서 2번째 행의 cnt 출력
// select cnt from (A) where rownum <= 2; 
// <= 2는 되는데 = 2는 안된다.
// 정렬한 것에다가 행번호를 붙여서 다시 서브쿼리로 만들어야 한다.
select cnt
from(
    select rownum n, b.*
    from (
        select bookid, count(*) cnt
        from orders
        group by bookid
        order by cnt desc
        ) b
    )
where n = 2;

// 도서번호별로 판매량중에서 판매량이 D보다 크거나 같은 도서번호 조회
select bookid
from (
    select bookid, count(*) cnt
    from orders
    group by bookid
    order by cnt desc
    )
where cnt >= (
            select cnt
            from(
                select rownum n, b.*
                from (
                    select bookid, count(*) cnt
                    from orders
                    group by bookid
                    order by cnt desc
                    ) b
                )
            where n = 2
            ); 

// book테이블로부터 bookid가 E에 해당하는 도서정보를 조회
select * from book
where bookid in (
            select bookid
            from (
                select bookid, count(*) cnt
                from orders
                group by bookid
                order by cnt desc
                )
            where cnt >= (
                    select cnt
                    from(
                        select rownum n, b.*
                        from (
                            select bookid, count(*) cnt
                            from orders
                            group by bookid
                            order by cnt desc
                            ) b
                        )
                    where n = 2
                        )
                );
                
---
select custId, sum(saleprice)
from orders
group by custId;

// 상관서브쿼리
select 
    custId,
    (select name from customer c where c.custId = o.custid) 이름,
    sum(saleprice)
from orders o
group by custId;

select 
    bookId,
    (select count(custId) from orders o where o.bookId = b.bookId) 판매건수
from book b
group by bookId;

select 
    (select b.bookName from book b where o.bookId = b.bookId) 도서명별,
    count(*)
from orders o
group by bookId;

select 
    (select d.name from department d where d.id = w.id) 부서별,
    count(w.workerId),
    avg(w.salary),
    max(w.salary)
from worker w
group by id;

alter table orders add bookname varchar2(50);

update orders o set bookname = (
    select bookName
    from book b
    where b.bookId = o.bookId
);

alter table orders drop column bookname;

desc orders;
select * from orders;

select avg(saleprice) from orders;

// 단일행연산자
select workerId, saleprice
from orders
where saleprice <= (select avg(saleprice) from orders);

select custId from customer
where address like '대한민국%';

select sum(saleprice)
from orders
where custId in (select custId from customer where address like '대한민국%');

delete orders where orderId =9;
rollback;
select orderId, saleprice
from orders
where saleprice > all (select saleprice from orders where custId = 4);

select orderId, saleprice
from orders
where saleprice > (select max(saleprice) from orders where custId = 4);

select custId, bookId from orders order by custId, bookId;

// 박지성이 구매한 도서번호 출력
select bookId from orders
where custId = (select custId from customer where name = '박지성');
// 고객번호별로 위의 도서를 구매한 건수를 출력
select custid,count(custid)
from orders
where bookid in (select bookid from
orders where custid = (select custid from customer
						where name = '박지성')) 
and custid <>
(select custid from customer where name = '박지성')
group by custid
order by count(custid) desc;

// 
