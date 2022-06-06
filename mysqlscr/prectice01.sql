use world;

desc city;  #테이블 구조 보기

#테이블조회
SELECT * FROM city;

# 테이블 조회
select name, population from city 
where population >= 500000
order by population desc;

# DB로 하는 Core 업무
# 1. 검색, 조회 	(SELECT, READ)
# 2. 삽입, 생성  	(INSERT, CREATE)
# 3. 수정, 변경 	(UPDATE)
# 4. 삭제		(DELETE)

# CRUD (삽입, 검색, 수정, 삭제)

select * FROM CITY;

SELECT id, name FROM city order by name asc;

select id, name, population from city 
where population > 90000000
order by population desc;

select * from city where id > 3000 order by id asc;



# madang  데이터 삽입하기
use madang;
DROP TABLE IF EXISTS Orders ;
DROP TABLE IF EXISTS Book;
DROP TABLE IF EXISTS Customer;
DROP TABLE IF EXISTS Imported_Book; 

CREATE TABLE Book (
  bookid      INTEGER PRIMARY KEY,
  bookname    VARCHAR(40),
  publisher   VARCHAR(40),
  price       INTEGER 
);

desc Book;
select * from book;

INSERT INTO Book VALUES(1, '축구의 역사', '굿스포츠', 7000);
INSERT INTO Book VALUES(2, '축구아는 여자', '나무수', 13000);
INSERT INTO Book VALUES(3, '축구의 이해', '대한미디어', 22000);
INSERT INTO Book VALUES(4, '골프 바이블', '대한미디어', 35000);
INSERT INTO Book VALUES(5, '피겨 교본', '굿스포츠', 8000);
INSERT INTO Book VALUES(6, '역도 단계별기술', '굿스포츠', 6000);
INSERT INTO Book VALUES(7, '야구의 추억', '이상미디어', 20000);
INSERT INTO Book VALUES(8, '야구를 부탁해', '이상미디어', 13000);
INSERT INTO Book VALUES(9, '올림픽 이야기', '삼성당', 7500);
INSERT INTO Book VALUES(10, 'Olympic Champions', 'Pearson', 13000);

CREATE TABLE  Customer (
  custid      INTEGER PRIMARY KEY,  
  name        VARCHAR(40),
  address     VARCHAR(50),
  phone       VARCHAR(20)
);

INSERT INTO Customer VALUES (1, '박지성', '영국 맨체스타', '000-5000-0001');
INSERT INTO Customer VALUES (2, '김연아', '대한민국 서울', '000-6000-0001');  
INSERT INTO Customer VALUES (3, '장미란', '대한민국 강원도', '000-7000-0001');
INSERT INTO Customer VALUES (4, '추신수', '미국 클리블랜드', '000-8000-0001');
INSERT INTO Customer VALUES (5, '박세리', '대한민국 대전',  NULL);

select * from Customer;

select publisher, price
from book
where bookname like '축구의 역사';

# 150p 데이터 검색
select bookname, price
from Book;
#도서의 번호, 도서이름, 출판사, 가격을 검색하시오.
select bookid, bookname, publisher, price
from Book;

# 도서 테이블에 있는 모든 출판사의 이름만 검색하시오.
select publisher from Book;
select count(publisher) from Book;

# 중복된 자료 제거
select distinct publisher from book;
select count(distinct publisher) from Book;

# 153p 가격이 10000원이상, 20000원 이하의 도서를 검색
select * from book where price >=10000 and price <=20000; 
select * from book where price between 10000 and 20000;
 
select phone
from Customer
where name = '김연아';

select * from book
where publisher='굿스포츠' or publisher='대한미디어';
select * from book
where publisher in ('굿스포츠', '대한미디어');


select * from customer
where name = '김연아' or name='박지성';
select * from customer
where name in ('김연아', '박지성');

# '축구의 역사'를 출간한 출판사 검색
select bookname, publisher 
from book
where bookname='축구의 역사';

select bookname, publisher 
from book
where bookname like '축구의 역사';

select bookname, publisher 
from book
where bookname like '%축구%';

select bookname, publisher 
from book
where bookname like '_구%';


# '축구'에 관한 도서 중 가격이 20000원 이상인 도서

select * from book
where bookname like '%축구%' and price >= 20000;

use madang;
select * from book
order by bookname asc;

select * from book
order by bookname desc;

# Quiz
# 축구라는 글자가 들어있는 자료들 중에 책의 가격이 20000원 이상인 데이터를 조회
select * from book
where bookname like '%축구%' and price >= 20000;



# 절대값
SELECT abs(-78), abs(+78)
FROM  Dual;

# 소수점 둘째자리까지 반올림
select round(3.141592, 2) from dual;

# 숫자 함수의 연산
SELECT 	custid ‘고객번호’, ROUND(SUM(saleprice)/COUNT(*), -2) ‘평균금액’
FROM 	Orders
GROUP BY custid;

select bookname '책이름', price '가격' from book;

# 문자열 함수 (일반 함수)
select concat('마당', '서점') as '문자열결합' from dual;

# Replace : 문자열을 치환하는 함수 
SELECT 	bookid, REPLACE(bookname, '야구', '농구') bookname, publisher, price
FROM 	Book;
SELECT 	bookid, REPLACE(bookname, '농구', '야구') bookname, publisher, price
FROM 	Book;

# 파일에 명시적 저장
commit; # 최종적 저장

# substr 
# name에서 성만 가져오기
select substr(name,1,1) from customer;
# name에서 이름만 가져오기
select substr(name, 2,2) from customer;

#'990419'
#1. 태어난 연도만 가져오기
select substr('990419',1,2) from dual;
#2. 생일만 가져오세요
select substr('990419', 3, 4) from dual;

CREATE TABLE Orders (
  orderid INTEGER PRIMARY KEY,
  custid  INTEGER ,
  bookid  INTEGER ,
  saleprice INTEGER ,
  orderdate DATE,
  FOREIGN KEY (custid) REFERENCES Customer(custid),
  FOREIGN KEY (bookid) REFERENCES Book(bookid)
);
desc Orders;

INSERT INTO Orders VALUES (1, 1, 1, 6000, STR_TO_DATE('2014-07-01','%Y-%m-%d')); 
INSERT INTO Orders VALUES (2, 1, 3, 21000, STR_TO_DATE('2014-07-03','%Y-%m-%d'));
INSERT INTO Orders VALUES (3, 2, 5, 8000, STR_TO_DATE('2014-07-03','%Y-%m-%d')); 
INSERT INTO Orders VALUES (4, 3, 6, 6000, STR_TO_DATE('2014-07-04','%Y-%m-%d')); 
INSERT INTO Orders VALUES (5, 4, 7, 20000, STR_TO_DATE('2014-07-05','%Y-%m-%d'));
INSERT INTO Orders VALUES (6, 1, 2, 12000, STR_TO_DATE('2014-07-07','%Y-%m-%d'));
INSERT INTO Orders VALUES (7, 4, 8, 13000, STR_TO_DATE( '2014-07-07','%Y-%m-%d'));
INSERT INTO Orders VALUES (8, 3, 10, 12000, STR_TO_DATE('2014-07-08','%Y-%m-%d')); 
INSERT INTO Orders VALUES (9, 2, 10, 7000, STR_TO_DATE('2014-07-09','%Y-%m-%d')); 
INSERT INTO Orders VALUES (10, 3, 8, 13000, STR_TO_DATE('2014-07-10','%Y-%m-%d'));

select * from orders;

select saleprice from Orders;

select sum(saleprice) from Orders;

use mydatabase;
select * from addr_table;
drop table addr_table;