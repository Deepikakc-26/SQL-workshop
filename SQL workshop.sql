create database myproject;

use myproject;


create table department(deptno int primary key, dname varchar(20), loc varchar(20));

describe department;

insert into department(deptno,dname,loc) values
(10,'accounting','new york'),
(20,'research','dallas'),
(30,'sales','chicago'),
(40,'operations','boston');

select * from department;

create table employee(empno int primary key,ename varchar(20),job varchar(20), mgr int, hiredate date,sal int,comm int,deptno int, foreign key(deptno) references department(deptno));

describe employee;

insert into employee(empno,ename,job,mgr,hiredate,sal,comm,deptno) values
(7369,'smith','clerk', 7902, '1980-12-17', 800, null, 20),
(7499,'allen','salesman', 7698, '1981-02-20', 1600, '300', 30);
insert into employee(empno,ename,job,mgr,hiredate,sal,comm,deptno) values
(7521,'ward','salesman', 7698, '1981-02-22', 1250, '500', 30),
(7566,'jones','manager', 7839, '1981-04-02', 2975, null, 20),
(7654,'martin','salesman', 7698, '1981-09-28', 1250, '1400', 30),
(7698,'blake','manager', 7839, '1981-05-01', 2850, null, 30),
(7782,'clark','manager', 7839, '1981-06-09', 2450, null, 10),
(7788,'scott','analyst', 7566, '1987-04-19', 3000, null, 20),
(7839,'king','president', null, '1981-11-17', 5000, null, 10),
(7844,'turner','salesman', 7698, '1981-09-08', 1500, '0', 30),
(7876,'adams','clerk', 7788, '1987-05-23', 1100, null, 20),
(7900,'james','clerk', 7698, '1981-12-03', 950, null, 30),
(7902,'ford','analyst', 7566, '1981-04-02', 3000, null, 20),
(7934,'miller','clerk', 7782, '1982-01-23', 1300, null, 10);

select * from employee;

select ename,deptno from employee where job='manager' and deptno=10;

select ename,hiredate from employee;

select ename,hiredate from employee where hiredate>'1985-12-31';

select *,sal*12 as annual_sal from employee;

select ename, sal,sal+(sal*0.2) as hike from employee;

select sal,deptno from employee where sal between 1250 and 4000 and deptno=10;

select ename,job,deptno from employee where job='clerk' or job='salesman' and deptno='10' or deptno='30' and sal>'1800';
select ename,job,deptno from employee where job in('clerk' ,'salesman') and deptno in('10','30') and sal>'1800';

select ename,deptno from employee where deptno not in(10,40);

select ename from employee where ename like 's%';
select ename from employee where ename like '%a';
select ename from employee where ename like '_m%';
select ename from employee where hiredate like '%-04-%';

select ename from employee where ename like '%a%a%';

select count(ename) from employee where ename like '%e%';

select avg(sal),sum(sal),count(ename),max(sal) from employee where job='president';

select deptno, max(sal) from employee group by deptno;
select job, max(sal) from employee group by job;
select job,deptno, max(sal) from employee group by job,deptno;
select count(ename),job from employee where ename like '%a%' group by job;
select count(ename),job from employee where ename like '%a%' group by job order by job desc;
select count(ename),job from employee where ename like '%a%' group by job order by job asc;

 select distinct ename
 from employee 
 where substring(ename,-1,1) in ('a','e','i','o','u');

select ename from employee where sal=(select sal from employee where ename='miller');
select ename, deptno from employee where deptno=(select deptno from employee where ename='smith');
select ename, hiredate from employee where hiredate>(select hiredate from employee where ename='jones');
select ename, sal, deptno from employee where sal>2000 and deptno=(select deptno from employee where ename='james');
select * from employee where sal=(select sal from employee where sal>'smith' and sal<'king');

select dname from department where deptno=(select deptno from employee where ename='miller');
select count(ename) from employee where deptno=(select deptno from department where dname='accounting');
select * from employee, department where job=(select job from employee where ename='miller') and loc=(select loc from department where loc='new york');
--------------------------------------------------------------------------------------------------
select ename from employee where sal>all(select sal from employee where job='salesman');
--
select * from employee where hiredate> all(select hiredate from employee where job='clerk');
--
select ename,sal from employee where sal<all(select sal from employee where job='manager');
--
select ename ,hiredate from employee where hiredate < all(select hiredate from employee where job='manager');
--
select ename from employee where hiredate> all(select hiredate from employee where job='manager')and sal> all (select sal from employee where job='clrek');

select * from employee where job='clerk' and hiredate<all(select hiredate from employee where job='salesman'); 

select * from employee where deptno=any(select deptno from department where dname='accounting' or dname='sales');

select dname from department where deptno=any(select deptno from employee where ename='smith'or ename='king'or ename='miller');

select * from employee where deptno=any(select deptno from department where loc='new york'or loc='chicago');

select * from employee where hiredate> all(select hiredate from employee where deptno=10);

select max(sal) from employee where sal<(select max(sal) from employee);
select min(sal) from employee where sal>(select min(sal) from employee);
                                 /*JOINS*/
select e.ename,d.deptno from employee as e cross join department d;

select e.ename,d.dname from employee e inner join department d on e.deptno=d.deptno;

select e.ename,d.loc from employee e inner join department d on e.deptno=d.deptno where job='manager';

select e.ename,e.sal,d.dname from employee e inner join department d on e.deptno=d.deptno;

select d.dname,e.sal from employee e inner join department d on e.deptno=d.deptno where dname='accounting';

select d.dname,e.job from employee e inner join department d on e.deptno=d.deptno where job like 's%' and dname like 's%';

select * from employee e,employee d where e.empno=d.mgr;
select * from employee e join employee d where e.empno=d.mgr;

select e1.ename, e1.sal,e2.ename,e2.sal from employee e1, employee e2 where e1.mgr=e2.empno;
select e1.ename, e2.ename as mgr,e2.deptno from employee e1 join employee e2 on e1.mgr=e2.empno where e1.job='clerk';
select e1.ename,e2.job as mgrjob from employee e1 join employee e2 on e1.mgr=e2.empno where e2.job='analyst';
select e1.ename, e2.ename as mgrname,e2.job from employee e1 join employee e2 on e1.mgr=e2.empno  where e1.job=e2.job;
select e1.ename, e1.sal,e2.ename as mgr,e2.sal from employee e1 join employee e2 on e1.mgr=e2.empno where e2.sal>e1.sal;

select * from employee e join department d on e.deptno=d.deptno;
select * from employee e natural join department d;

select e.ename,e.sal,d.dname from employee e natural join department d where e.deptno=(select e1.deptno from employee e1 where e1.job='president') order by e.sal desc ;
select d.dname,avg(e.sal) from employee e natural join department d where e.deptno=d.deptno and e.hiredate>'1980-12-31' group by d.dname  order by avg(e.sal) desc;
select e.ename,e.hiredate,d.dname  from employee e natural join department d where e.hiredate=all(select e1.hiredate from employee e1 join employee e on e.deptno=e1.deptno);



































