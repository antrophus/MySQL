/*******************************************
* 복습
*******************************************/
-- 기본구조 select문 = select절, from절
select * 
from employees;

-- 특수한경우
select now() from dual; -- 가상의 테이블 dual
select now(); -- MySQL에서만 가능


-- 사칙연산
select first_name 'f-name'
		,salary  월급
		,salary*12 '연 봉'
from employees;

select first_name 이름
		,last_name 성
        ,concat(first_name,'-', last_name) 성명
from employees;

-- where절  :위치는 select from 뒤에 씀

select first_name
		,salary
from employees
where salary >= 17000;

-- 비교연산자, 조건이 여러개일 때, between, in 

/*******************************************
* 2일차
*******************************************/
select first_name
		,salary
from employees
where first_name = 'lex'; -- 딱 맞는 값을 찾아준다. 

select  first_name
		,salary
from 	employees
where first_name like 'l%'
; -- l로 시작하는 문자열을 찾아줌

select  first_name
		,salary
from 	employees
where first_name like '%l'
; -- l로 끝나는 문자열을 찾아줌

select  first_name
		,salary
from 	employees
where first_name like '%l%'
; -- ㅣ을 포함하는 문자열을 찾아줌

select  first_name
		,salary
from 	employees
where first_name like 'ㅣ__' -- _ 가 두개
; -- ㅣ로 시작하고 세글자인 문자열을 찾아줌

-- 이름에 am 을 포함한 사원의 이름과 월급을 출력하세요

select first_name 이름
		,salary 월급
from   employees
where first_name like '%am%'
;

-- 이름의 네번째 글자가 a인 사원의 이름을 출력하세요

select first_name 이름
from employees
where first_name like '___a%'
;

-- 이름의  두번째 글자가 a 인 사원의 이름과 월급을 출력하세요
select first_name
		,salary
from employees
where first_name like '_a%'
;

-- 이름이 4글자인 사원중 끝에서 두번째 글자가 a인 사원의 이름을 출력하세요
select first_name
from employees
where first_name like '__a_'
;

-- null 은 계산되지 않는다.(계속 null)
-- 월금 13000 이상 15000 이하인 사원 정보
select * 
from employees
where salary between 13000 and 15000;
;
-- 수당을 계산하세요(between 13000 and 15000)
select	first_name
		,salary
		,commission_pct
        ,salary * commission_pct 수당 
from	employees
where salary between 13000 and 15000
;

select  first_name
		,salary
        ,commission_pct
        ,salary * commission_pct 수당 
from 	employees
where commission_pct is not null
and salary between 13000 and 15000 
;

-- 담당 매니저가 없고 커미션 비율이 없는 직원의 이름과 매니저 아이디 커미션 비율을 출력하세요
select  first_name
		,manager_id
        ,commission_pct
from 	employees
where manager_id is null
and commission_pct is null
;

-- 부서가 없는 직원의 이름과 월급을 출력하세요
select  first_name
		,salary
        ,department_id
from 	employees
where department_id is null
;

-- order by 절
-- 직원의 이름과 월급을 월급이 많은 직원부터 출력하세요

select  first_name 이름
		,salary 월급
from 	employees
order by salary desc -- 내림차순 'desc' , 오름차순 'asc'
;

-- 월급이 9000이상인 직원의 이름과 월급을 월급이 많은 직원부터 출력하세요
-- 정렬 조건 1. 월급 높은 사람부터, 2.같은 값이면 이름의 내림차순(Z->A) 

select  first_name 이름
		,salary 월급
from 	employees
where 	salary > '9000'
order by salary desc, first_name desc
;

-- 부서번호를 오름차순으로 정렬하고 부서번호, 월급, 이름을 출력하세요
select  department_id 부서번호
		,salary 월급
        ,first_name 이름
from 	employees
order by department_id asc
;

-- ▪ 월급이 10000 이상인 직원의 이름 월급을 월급이 큰직원부터 출력하세요
select  first_name 이름
		,salary 월급
from 	employees
where   salary >10000
order by salary desc
;

-- ▪ 부서번호를 오름차순으로 정렬하고 부서번호가 같으면 월급이 높은 사람부터 부서번호 월급 이름을 출력하세요
select  department_id 부서번호
		,salary 월급
        ,first_name
from 	employees
order by department_id asc, salary desc
;

-- ▪ 직원의 이름, 급여, 입사일을 이름의 알파벳 올림차순으로 출력하세요
select  first_name
		,salary
		,hire_date
from 	employees
order by first_name asc
;

-- ▪ 직원의 이름, 급여, 입사일을 입사일이 빠른 사람 부터 출력하세요
select  first_name
		,salary
        ,hire_date
from 	employees
order by hire_date asc
;

-- 실행순서 공부(실행 안되는 이유 공부)
select  first_name 이름
		,salary 월급
from 	employees
where   salary >10000
order by 월급 desc  -- 가능
;

select  first_name 이름
		,salary 월급
from 	employees
where   월급 >10000  -- 불가능
order by salary desc
;

/*******************************************
* 단일행 함수
*******************************************/
-- 단일행 함수 > 숫자함수


-- round() : 반올림
select  round(123.123, 2), -- 123.12 (반올림할 수, 반올림 자리수)
		round(123.126, 2),  -- 123.13 (2째자리까지 표현 이하 자리수 반올림)
        round(234.567, 0), -- 235
        round(123.456, 0), -- 123
        round(123.456),     -- 123
        round(123.126,-1),  -- 120
        round(123.126,-2)   -- 100
        ;
        
-- ceil() : 올림
select  ceil(123.123), -- 124 (올림할 수, 올림 자리수)
		ceil(123.126),  -- 124 (2째자리까지 표현 이하 자리수 올림)
        ceil(234.567), -- 235
        ceil(123.456), -- 124
        ceil(123.456),  -- 124
        ceil(123.126),  -- 124
        ceil(123.126)   -- 124
        ;
-- floor() : 내림   
select  floor(123.456),    	-- 123
		floor(123.789),		-- 123
        floor(123.7892313),	-- 123
        floor(987.1234);	-- 987

-- truncate(숫자, m) : 버림, 소수점 m 자리까지 표현
select  truncate(1234.34567, 2),  -- 1234.34
		truncate(1234.34567, 0),  -- 1234
        truncate(1235.34567, -2)  -- 1200
        ;

-- POWER(숫자, n), POW(숫자, n): 숫자의 n승
select  pow(12,2), 	-- 144
		power(12,2)	-- 144
        ;

-- SQRT(숫자): 숫자의 제곱근
select  sqrt(144) -- 12
		;

-- SIGN(숫자): 숫자가 음수이면 -1, 0이면 0, 양수이면 1
select  sign(123),	-- 1
		sign(0),	-- 0
		sign(-123)	-- -1
        ;

-- ABS(숫자): 절대값
select  abs(123),	-- 123
		abs(0),		-- 0
		abs(-123)	-- 123
		;
        
-- GREATEST(x, y, z, ...): 괄호안의 값중 가장 큰값
select  greatest(2, 0, -2),				-- 2
		greatest(4, 3.2, 5.25),			-- 5.22		
		greatest('B', 'A', 'C', 'c')	-- c
		;

-- LEAST(x, y, z, ...): 괄호안의 값중 가장 작은값
select  least(2, 0, -2),			-- -2
		least(4, 3.2, 5.25),		-- 3.2
		least('B', 'A', 'C', 'c')	-- A
		;

-- 단일행 함수 > 문자함수
select concat('안녕', '하세요');
select concat('안녕', '-', '하세요');
select concat(first_name, ' ', last_name) 이름
from employees;

-- CONCAT_WS(s, str1, str2, ..., strn): str1, str2, ..., strn을 연결할때 사이에 s 로 연결
-- *with seperator
select concat_ws('-', 'abc', '123', '가나다');
select concat_ws('-', first_name, last_name, phone_number)
from employees;

-- LCASE(str) 또는 LOWER(str): str의 모든 대문자를 소문자로 변환
select  first_name,
		lcase(first_name),
		lower(first_name),
		lower('ABCabc!#$%'),
		lower('가나다')
from employees;

-- UCASE(str) 또는 UPPER(str): str의 모든 소문자를 대문자로 변환
select  first_name,
		ucase(first_name),
		upper(first_name),
		upper('ABCabc!#$%'),
		upper('가나다')
from employees;

-- LENGTH(str): str의 길이를 바이트로 반환
-- CHAR_LENGTH(str) 또는 CHARACTER_LENGTH(): str의 문자열 길이를 반환
select  first_name,
		length(first_name),				-- 바이트수 *조심
		char_length(first_name),		-- 굴자수
		character_length(first_name)	-- 글자수
from employees;

select  length('유재석')					-- 바이트수 *조심
		,char_length('유재석')			-- 글자수
        ,character_length('유재석')		-- 글자수
        ;

-- SUBSTRING(str, pos, len) 또는 SUBSTR(str, pos, len): str의 pos 위치에서 시작하여 len 길이의 문자열 반환
select  first_name
		,substr(first_name, 1, 3) -- 1글자부터 세서 3글자
        ,substr(first_name, 2, 3) -- 2번째 글자부터 세서 3글자 
        ,substr(first_name, -3, 2) -- 뒤에서 3번째 글자부터 세서 2글자
from employees
;

select  substr('901112-1234567',8,1) 	-- 성별
		,substr('901112-1234567',-7,1) 	-- 성별
        ,substr('901112-1234567',3,2)		-- 월
        ,substr('901112-1234567',5,2)		-- 일
;

-- LPAD(str, len, padstr): str 문자열 왼쪽에 padstr 문자열을 추가하여, 전체 문자열의 길이가 len이 되도록 만듬
-- RPAD(str, len, padstr): str 문자열 오른쪽에 padstr 문자열을 추가하여, 전체 문자열의 길이가 len이 되도록 만듬
select  first_name,
		lpad(first_name,10,'*'),
		rpad(first_name,10,'*')
from employees;

-- TRIM(str): str의 양쪽에 있는 공백 문자를 제거
select  concat('|', '          안녕하세요          ', '|' ),
		concat('|', trim('          안녕하세요          '), '|'),
        concat('|', ltrim('          안녕하세요          '), '|' ),
        concat('|', rtrim('          안녕하세요          '), '|' ),
        trim(concat('|', ('          안녕하세요          '), '|' ))
        ;
        
-- REPLACE(str, from_str, to_str): str에서 from_str을 to_str로 변경        
select  first_name,
		replace(first_name, 'a', '****')
from employees
;

-- 응용 조합 replace + substr
select  first_name,
		replace(first_name, 'a', '*')
        ,substr(first_name, 2, 3)
        ,replace(first_name, substr(first_name, 2, 3), '***' )
from employees
;

-- 단일행 함수 > 날짜함수
-- CURRENT_DATE() 또는 CURDATE(): 현재 날짜를 반환
-- CURRENT_TIME() 또는 CURTIME(): 현재 시간을 반환
-- CURRENT_TIMESTAMP() 또는 NOW(): 현재 날짜와시간을 반환
select  current_date(), 
		curdate();
select  current_time()
		, curtime();
select  current_timestamp()
		, now();
        
-- ADDDATE() 또는 DATE_ADD(): 날짜 시간 더하기
-- SUBDATE() 또는 DATE_SUB(): 날짜 시간 빼기    
select  adddate('2021-06-20 00:00:00', INTERVAL 1 YEAR) 1년후,
		adddate('2021-06-20 00:00:00', INTERVAL 1 MONTH) 1달후,
		adddate('2021-06-20 00:00:00', INTERVAL 1 WEEK) 1주후,
		adddate('2021-06-20 00:00:00', INTERVAL 1 DAY) 1일후,
		adddate('2021-06-20 00:00:00', INTERVAL 1 HOUR) 1시간후,
		adddate('2021-06-20 00:00:00', INTERVAL 1 MINUTE) 1분후,
		adddate('2021-06-20 00:00:00', INTERVAL 1 SECOND) 1초후
        ;
        
select  subdate('2021-06-20 00:00:00', INTERVAL 1 YEAR) 1년전,
		subdate('2021-06-20 00:00:00', INTERVAL 1 MONTH) 1달전,
		subdate('2021-06-20 00:00:00', INTERVAL 1 WEEK) 1주전,
		subdate('2021-06-20 00:00:00', INTERVAL 1 DAY) 1일전,
		subdate('2021-06-20 00:00:00', INTERVAL 1 HOUR) 1시간전,
		subdate('2021-06-20 00:00:00', INTERVAL 1 MINUTE) 1분전,
		subdate('2021-06-20 00:00:00', INTERVAL 1 SECOND) 1초전
        ;
 
-- DATEDIFF(): 두 날짜간 일수차
-- TIMEDIFF(): 두 날짜시간 간 시간차
select  datediff('1982-02-28 01:05:05', '2021-06-21 01:00:00')	'며칠 차이',
		timediff('2021-06-21 01:05:05', '2021-06-21 01:00:00') '몇시간 차이'
		;
select  floor(datediff(now(), '1999-11-19')/365) 나이
		;
select  first_name
		,hire_date
        ,floor(datediff(now(), hire_date)/365) workyear
        from employees
        order by workyear desc
        ;

-- 변환함수
-- 날짜(숫자) --> 문자열        
-- DATE_FORMAT(date, format): date를 format형식으로 변환
select  now(),
		date_format(now(), '%Y년 %m월 %d일 %H시%i분%s초 %p') 오늘,
		date_format(now(), '%Y-%m-%d(%a) %H:%i:%s %p') Today

from dual;

-- 숫자 --> 문자열 (,) 넣기
-- FORMAT(숫자, p): 숫자에 콤마(,) 를 추가, 소수점 p자리까지 출력
select  format(1234567.89, 2) -- 1,234,567.89
		;
select  format(1234567.89, 0) -- 1,234,568
		;

select  first_name
		,salary
        ,format(salary, 0)
from employees
;

-- IFNULL(컬럼명, null일때값): 컬럼의 값이 null일때 정해진값을 출력
select  commission_pct
		,ifnull(commission_pct, 0)
from	employees
		;

select  first_name 이름
		,format(floor(salary),0) 월급
		,ifnull(commission_pct, '없음') 수당율
        ,format(floor(salary*ifnull(commission_pct, 0)+500),0) '추가 수당'
        ,format(floor(salary+(salary*ifnull(commission_pct, 0)+500)),0) 총수익
        ,floor(salary+(salary*ifnull(commission_pct, 0)+500)) this
        from employees
		order by this desc
		;