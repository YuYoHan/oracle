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

// having ���
// group by ���� ��Ÿ�� ����� ���Ͽ� ���ǽ��� �ְ��� �� �� ���
select b.bookname "������", count(custId) "�ǸŰǼ�"
from orders o
join book b on b.bookid = o.bookid 
where b.publisher in('�̻�̵��','���ѹ̵��')
group by b.bookname having count(custId) >= 2
order by count(custId);

select c.name "����", sum(salePrice), count(*)
from orders o
join customer c on c.custid = o.custid
group by c.name having sum(salePrice) >= 10000
order by sum(salePrice) desc;

select d.name "�μ���", count(workerId), sum(salary), avg(salary)
from worker w
join department d on w.id = d.id
where d.location in ('�Ǳ�','����')
group by d.name having count(workerId) >= 2
order by sum(salary) desc, avg(salary);

select b.bookname "������", count(*)
from orders o
join book b on b.bookId = o.bookId
where b.bookname like '%�౸%'
group by b.bookname 
order by count(*) desc;

---
// �ڼ��� ������ �����ڴ� �̵����Դϴ�.
// worker ���̺��� mgr�� worker ���̺��� workerId�� ����
// ���� ��� ������ �̸��� ������ �̸��� ����ؾ� �Ѵٸ� self ����
// �� �� �ִ�. ������ ���������� ���̺��� workerId��� �� �Ѱ��� �ִ�.
// �̰��� �ѹ��� �����̶�� ���� �ѹ��� �����ڷ� ���� 
// �ΰ��� �����Ͽ� �����̸��� ������ �̸��� ��ȸ�� �� �ִ�.
// e : ���� m : ������
select e.name "����", m.name "������" 
from worker e
join worker m on e.mgr = m.workerId;
