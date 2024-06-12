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
