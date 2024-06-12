// day02 연습
select job"직책",count(workerId), avg(salary) 
from worker 
group by job 
order by count(workerId) desc;

select d.name "부서명", count(workerId), sum(salary), avg(salary)
from worker w
join department d on w.id = d.id
group by d.name
order by sum(salary) desc;

select w.job "직책",avg(salary) "평균금액"
from worker w
join department d on w.id = d.id
where d.name like '%개발%'
group by w.job
order by avg(salary)desc;

select b.bookname "도서명", count(custId) "판매건수"
from orders o
join book b on b.bookid = o.bookid 
where b.publisher in('이상미디어','대한미디어')
group by b.bookname
order by count(custId);

// having 사용
// group by 절에 나타난 결과에 대하여 조건식을 주고자 할 때 사용
select b.bookname "도서명", count(custId) "판매건수"
from orders o
join book b on b.bookid = o.bookid 
where b.publisher in('이상미디어','대한미디어')
group by b.bookname having count(custId) >= 2
order by count(custId);

select c.name "고객명", sum(salePrice), count(*)
from orders o
join customer c on c.custid = o.custid
group by c.name having sum(salePrice) >= 10000
order by sum(salePrice) desc;

select d.name "부서명", count(workerId), sum(salary), avg(salary)
from worker w
join department d on w.id = d.id
where d.location in ('판교','종각')
group by d.name having count(workerId) >= 2
order by sum(salary) desc, avg(salary);

select b.bookname "도서명", count(*)
from orders o
join book b on b.bookId = o.bookId
where b.bookname like '%축구%'
group by b.bookname 
order by count(*) desc;

---
// 박성빈 직원의 관리자는 이동준입니다.
// worker 테이블의 mgr은 worker 테이블의 workerId를 참조
// 만약 모든 직원의 이름과 관리자 이름을 출력해야 한다면 self 조인
// 할 수 있다. 실제로 물리적으로 테이블은 workerId라는 것 한개만 있다.
// 이것을 한번은 직원이라고 보고 한번은 관리자로 보아 
// 두개를 조인하여 직원이름과 관리자 이름을 조회할 수 있다.
// e : 직원 m : 관리자
select e.name "직원", m.name "관리자" 
from worker e
join worker m on e.mgr = m.workerId;
