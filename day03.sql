// day02 ����
select job"��å",count(workerId), avg(salary) 
from worker 
group by job 
order by count(workerId) desc;

select d.name "�μ���", count(workerId), sum(salary), avg(salary)
from worker w
join department d on w.id = d.id
group by d.name
order by sum(salary) desc;

select w.job "��å",avg(salary) "��ձݾ�"
from worker w
join department d on w.id = d.id
where d.name like '%����%'
group by w.job
order by avg(salary)desc;

select b.bookname "������", count(custId) "�ǸŰǼ�"
from orders o
join book b on b.bookid = o.bookid
where b.publisher in('�̻�̵��','���ѹ̵��')
group by b.bookname
order by count(custId);
