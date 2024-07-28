/*
서브쿼리(SUBQUERY) SQL 문제입니다.
문제1.
평균 월급보다 적은 월급을 받는 직원은 몇명인지 구하시요.
(56건)
*/
select avg(salary)
from employees
;

select count(*) 'count(salary)'
from employees
where salary < (select avg(salary)
				from employees)
;


/*
문제2.
평균월급 이상, 최대월급 이하의 월급을 받는 사원의
직원번호(employee_id), 이름(first_name), 월급(salary), 평균월급, 최대월급을 월급의
오름차순으로 정렬하여 출력하세요
(51건)
*/
select employee_id 직원번호
		,first_name 이름
        ,salary 월급
        ,round(a.avg,0) 평균월급
        ,m.max 최대월급
from employees e , (select avg(salary) avg from employees) a, (select max(salary) max from employees) m
where salary >= (select avg(salary) from employees)
and salary <= (select max(salary) from employees)
;

/*
문제3.
직원중 Steven(first_name) king(last_name)이 소속된 부서(departments)가 있는 곳의 주소를
알아보려고 한다.
도시아이디(location_id), 거리명(street_address), 우편번호(postal_code), 도시명(city),
주(state_province), 나라아이디(country_id) 를 출력하세요
(1건)
*/
# 쿼리 풀이 - 복습 필요!!!!!!!
# 1st step.
(select department_id  -- > 'steven king'의 department_id : 90
from employees
where first_name = 'steven' and last_name = 'king') 
;
# 2nd step.
(select location_id  -- > 'steven king'의 location_id : 1700
from departments d
where d.department_id = (   select e.department_id  -- > 'steven king'의 department_id : 90
							from employees e
							where first_name = 'steven' and last_name = 'king')  )
;
# 3rd together into one.
select * -- > 'steven king'의 locations 정보 모두
from locations l
where l.location_id = (select location_id  -- > 'steven king'의 location_id : 1700 
						from departments d
						where d.department_id = (select e.department_id  -- > 'steven king'의 department_id : 90
													from employees e
													where first_name = 'steven' and last_name = 'king'))
;
# result
select l.location_id AS '도시아이디'
     , l.street_address AS '거리명'  
     , l.postal_code AS '우편번호'
     , l.city AS '도시명'
     , l.state_province AS '주'
     , l.country_id AS '나라아이디' 
from locations l
where l.location_id = (select location_id  -- > 'steven king'의 location_id : 1700 
						from departments d
						where d.department_id = (select e.department_id  -- > 'steven king'의 department_id : 90
													from employees e
													where first_name = 'steven' and last_name = 'king'))
;

# join 이용 풀이
select l.location_id 도시아이디
		,l.street_address 거리명
        ,l.postal_code 우편번호
        ,l.city 도시명
        ,l.state_province 주
        ,l.country_id 나라아이디
from employees e
join departments d on e.department_id = d.department_id
join locations l on d.location_id = l.location_id
where e.first_name = 'steven' and e.last_name = 'king'
;


/*
문제4.
job_id 가 'ST_MAN' 인 직원의 월급보다 작은 직원의 사번, 이름, 월급을 월급의 내림차순으로
출력하세요 -ANY연산자 사용
(74건)
*/

select employee_id 사번
		,first_name 이름
        ,salary 월급
from employees
where salary <any (select salary
					from employees
					where job_id = 'st_man')
order by salary desc
;

/*
문제5.
각 부서별로 최고의 월급을 받는 사원의 직원번호(employee_id), 이름(first_name)과 월급(salary)
부서번호(department_id)를 조회하세요
단 조회결과는 월급의 내림차순으로 정렬되어 나타나야 합니다.
조건절비교, 테이블조인 2가지 방법으로 작성하세요
(11건)
*/
# 테이블조인
/*
select max(salary)
		,department_id
from employees
group by department_id
;*/
select e.employee_id 사원번호
		,e.first_name 이름
        ,e.salary 월급
        ,e.department_id 부서번호
from employees e, (select max(salary) msalary
							,department_id
					from employees
					group by department_id) m
where e.department_id = m.department_id
and e.salary = m.msalary 
order by e.salary desc                 
;
# 조건절비교
select employee_id 사원번호
		,first_name 이름
        ,salary 월급
        ,department_id 부서번호
from employees
where (department_id, salary) in (select department_id, max(salary)
									from employees
									group by department_id)
order by salary desc
;

/*
문제6.
각 업무(job) 별로 월급(salary)의 총합을 구하고자 합니다.
월급 총합이 가장 높은 업무부터 업무명(job_title)과 월급 총합을 조회하시오
(19건)
*/
/*
select  job_id
		,sum(salary)
from employees
group by job_id;*/

select j.job_title 업무명
		,s.sum '월급 총합'
from jobs j,   (select job_id
						,sum(salary) sum
				from employees
				group by job_id) s
where j.job_id = s.job_id
order by s.sum desc             
;
 

/*
문제7.
자신의 부서 평균 월급보다 월급(salary)이 많은 직원의 직원번호(employee_id),
이름(first_name)과 월급(salary)을 조회하세요
(38건)
*/
/*
select department_id
		,avg(salary)
from employees
group by department_id
;
*/
select	employee_id 직원번호
		,first_name 이름
		,salary 월급
        ,a.avg
from employees e, (select department_id, avg(salary) avg
					from employees
					group by department_id) a
where e.salary > a.avg 
and e.department_id = a.department_id
;

/*
문제8.
직원 입사일이 11번째에서 15번째의 직원의 사번, 이름, 월급, 입사일을 입사일 순서로 출력하세요
*/

select   employee_id
		,first_name
		,salary
        ,hire_date
from employees
order by hire_date asc
limit 10, 5 -- 11번째부터 5개
;