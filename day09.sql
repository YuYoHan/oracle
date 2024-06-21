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

