use madang;

select * from orders;

select * from customer;

select sum(saleprice) from orders where custid = 2; 

select sum(saleprice) as 합계,
avg(saleprice) as 평균,
min(saleprice) as 최저,
max(saleprice) as 최고
from orders;

# 고객별로 주문한 도서의 총 수량과 총 판매액
select custid, count(*) as 총수량, sum(saleprice) as 판매액
from orders group by custid;


select custid, count(*) as 도서수량
from orders 
where saleprice >= 8000
group by custid
having count(*) >= 2;

# 판매액이 가장 높은 고객 id 순으로 정렬해 주세요.
select custid, sum(saleprice) 총액, count(*) 도서수량
from orders 
group by custid
order by saleprice desc;


# JOIN

select count(*) from customer;
select * from orders;
select * from customer;
select count(*) from orders;
select count(*) from customer, orders;

select * from customer, orders
where customer.custid = orders.custid
order by customer.custid;

# 고객의 이름과 고객이 주문한 도서의 판매가격

select name, saleprice 
from customer, orders
where customer.custid=orders.custid;

select name, sum(saleprice) 
from customer, orders
where customer.custid=orders.custid
group by customer.name
order by customer.name;

select * from book;

# 3개 Join
select name, bookname, orderdate 
from book, customer, orders
where customer.custid = orders.custid
and book.bookid=orders.bookid;


#LEFT OUTER JOIN으로 널 값까지 출력
SELECT	Customer.name, saleprice
FROM Customer LEFT OUTER JOIN Orders 
ON Customer.custid =Orders.custid;


# 부속질의
SELECT bookname
FROM book
WHERE price = (select max(price) from book);


#출판사별로 출판사의 평균 도서 가격보다 비싼 도서를 구하시오.
select b1.bookname
from book b1
where b1.price > (select avg(b2.price)
				from book b2
                Where b2.publisher=b1.publisher);
