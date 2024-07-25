# 오늘 과제 형식
-- Practice06_book.sql 깃허브
/*-----------------------------
root 계정에서 할일
-------------------------------*/
-- book계정만들기
create user 'book'@'%' identified by '1234';

-- book권한부여
grant all privileges on book_db.* to 'book'@'%';

-- book_db만들기
create database book_db
	default character set utf8mb4
    collate utf8mb4_general_ci
    default encryption='n'
;

/*-----------------------------
book 계정에서 할일
-------------------------------*/
-- 작가 테이블 만들기
create table author(
	author_id		integer 	primary key		auto_increment
    ,author_name		varchar(50)	not null
    ,author_desc		varchar(100)
);

-- 책 테이블 만들기
create table book(
	book_id		integer		primary key		auto_increment
    ,title		varchar(100)	not null
    ,pubs		varchar(100)
    ,pub_date	datetime
    ,author_id integer,
    constraint book_fk foreign key(author_id)
    references author(author_id)
);

-- 작가 등록(6개)
insert into author
	value(
		null
        ,'이문열'
        ,'경북 영양'
);
insert into author
	value(
		null
        ,'박경리'
        ,'경상남도 통영'
);
insert into author
	value(
		null
        ,'유시민'
        ,'17대 국회의원'
);
insert into author
	value(
		null
        ,'기안84'
        ,'기안동에서 산 84년생'
);
insert into author
	value(
		null
        ,'강풀'
        ,'온라인 만화가 1세대'
);
insert into author
	value(
		null
        ,'김영하'
        ,'알쓸신잡'
);


-- 책등록(8개)
insert into book
	value(
		null
        ,'우리들의 일그러진 영웅'
        ,'다림'
        ,'1998-02-22'
        ,1
);
insert into book
	value(
		null
        ,'삼국지'
        ,'민음사'
        ,'2002-03-01'
        ,1
);
insert into book
	value(
		null
        ,'토지'
        ,'마로니에북스'
        ,'2012-08-15'
        ,2
);
insert into book
	value(
		null
        ,'유시민의 글쓰기 특강'
        ,'생각의 길'
        ,'2015-04-01'
        ,3
);
insert into book
	value(
		null
        ,'패션왕'
        ,'중앙북스(books)'
        ,'2012-02-22'
        ,4
);
insert into book
	value(
		null
        ,'순정만화'
        ,'재미주의'
        ,'2011-08-03'
        ,5
);
insert into book
	value(
		null
        ,'오직두사람'
        ,'문학동네'
        ,'2017-05-04'
        ,6
);
insert into book
	value(
		null
        ,'26년'
        ,'재미주의'
        ,'2012-02-04'
        ,5
);

-- 책+작가 리스트 출력
select *
from book b, author a
where a.author_id = b.author_id
order by book_id asc
;

-- 강풀정보 변경(author_desc 정보를 '서울특별시'로 변경해 보세요)
update author set author_desc = '서울특별시'
    where author_id = 5 
;

-- 책+작가 리스트 출력
select  b.book_id
		,b.title
        ,b.pubs
        ,b.pub_date
        ,a.author_id
        ,a.author_name
        ,a.author_desc
from book b, author a
where a.author_id = b.author_id
order by book_id asc
;
-- 기안84 작가 삭제
delete from author where author_id = 4;
-- -->오류발생 이유 생각해보기
 # 이유 : author 테이블의 author_id와 book 테이블의 author_id가 (author테이블)pk-(book테이블)fk 관계로 엮여 있어서 지울수 없다.  

-- 나머지 배운 명령어 해보기