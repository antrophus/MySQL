/**********************************************
select 문(조회)
***********************************************/
-- select ~ from 절
-- 테이블 전체 조회하기

select * from employees;
select * from departments;
select * from locations;
select * from countries;
select * from regions;
select * from jobs;
select * from job_history; -- 대소문자 구별 없음
select * from job_HIstory;

select * from employees;
select first_name from employees;
select first_name, phone_number, hire_date, salary from employees;

select first_name 이름
		,phone_number 전화번호
        ,hire_date 입사일
        ,salary 월급
from employees;

select salary 월급
		,salary*12 연봉
from employees;

select  salary '월급'
		,salary-100 '월급 - 식대'
		,salary*12 '연봉'
        ,salary*12+5000 '연봉 + 보너스'
        ,salary/30 '일급'
        ,employee_id/3
        ,employee_id%3
from employees;

select first_name, last_name,
		concat(first_name, last_name),
        concat(first_name, last_name) as 이름,
        concat(first_name, '-', last_name) as 이름,
        concat(first_name, ' ', last_name, ' 입사일은 ', hire_date, ' 입니다') 이름2
from employees;

-- 전체직원의 정보를 다음과 같이 출력하세요
select concat(first_name, '-', last_name) 성명
		,salary 월급
        ,salary*12 연봉
        ,salary*12+5000 보너스
        ,phone_number 전화번호
from employees;

select first_name
		,salary
        ,now() as 기준일
        ,3 as 옵션
        ,'자바ex' 회사명
from employees;

select 	now() 현재시간
from dual; -- Oracle의 경우는 select ~ from ~; 문법을 지켜주기 위해 가상의 테이블 'dual'을 입력해야 한다. Mysql은 생략가능.

-- 이름이랑 부서 번호를 출력하세요.

select first_name 이름
		,department_id 부서아이디
        ,salary 급여
from employees
where department_id = 10;

-- 월급이 15000 이상인 사원들의 이름과 월급을 출력하세요
select first_name 이름
		,salary 월급
from employees
where salary >=15000;

-- 07/01/01 일 이후에 입사한 사원들의 이름과 입사일을 출력하세요
select first_name 이름
		,hire_date 입사일
from employees
where hire_date >= '2007-01-01';

-- 이름이 Lex인 직원의 이름과 월급을 출력하세요
select first_name 이름
		,salary 월급
from employees
where binary first_name = 'Lex'; -- 문자열 대소문자를 구별하지 않는다. 구별하려면 binary 사용

-- 월급이 14000 이상 17000이하인 사원의 이름과 월급을 구하시오.
select first_name 이름
		,salary 급여
from employees
where salary <=17000
and salary >=14000;

-- 월급이 14000 이하이거나 17000 이상인 사원의 이름과 월급을 출력하세요
-- 입사일이 04/01/01 에서 05/12/31 사이의 사원의 이름과 입사일을 출력하세요

select first_name 이름
		,salary 월급
from employees
where salary <=14000
or salary >=17000;

select first_name 이름
		,salary 월급
from employees
where salary between 14000 and 17000;

-- 월급이 2100, 3100, 4100, 5100인 사원의 이름과 월급을 구하시오
select first_name 이름
		,salary 월급
from employees
where salary = 2100
or    salary = 3100
or    salary = 4100
or    salary = 5100;

select first_name 이름
, salary 월급
from employees
where salary in(2100, 3100, 4100, 5100);

select  first_name 이름
		, hire_date 입사일 
from employees
where hire_date > '04/01/01'
and hire_date < '05/12/31';

-- Neena, Lex, John의 이름, 성, 월급을 구하시오
select first_name
,last_name
,salary
from employees
where first_name in('neena', 'lex', 'john');