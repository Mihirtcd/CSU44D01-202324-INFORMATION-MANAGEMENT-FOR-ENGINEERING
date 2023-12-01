==============================
Create New Database named "food":
==============================
create database food;

use food;

==============================
Create Entity Table:
==============================
===============
customer
===============
create table customer(customerid integer Primary Key,
Name varchar(20) Not null,
address varchar(20),
phno integer);

insert into customer values(101,'Rajesh','Mumbai',237856);
insert into customer values(102,'Girish','Pune',88765);
insert into customer values(103,'Mahesh','Vasai',787556);
insert into customer values(104,'Diya','Mumbai',98764);
insert into customer values(105,'Rakhi','Rajasthan',88765);
insert into customer values(106,'Kiran','Gujarat',98765);

===============
Menu_Item
===============
create table Menu_Item(Item_id integer Primary key,
name varchar(20) not null,
Category varchar(30) Not null,
description varchar(20),
Price integer);

insert into Menu_Item values(501,'Salad','Starter','',120);
insert into Menu_Item values(502,'Pizza','Starter','',350);
insert into Menu_Item values(503,'Momos','Starter','',220);
insert into Menu_Item values(504,'Chapati','Main','',80);
insert into Menu_Item values(505,'Rice','Main','',190);
insert into Menu_Item values(506,'Sabji','Main','',450);

===============
orders
===============
create table orders(orderid integer Primary key,
customerid integer references customer(customerid),
Total_Cost integer Not null,
order_date date,
item_id integer references Menu_Item(item_id));

insert into orders values(12001,101,4500,'2001-08-12',504);
insert into orders values(12002,103,1500,'2001-09-12',503);
insert into orders values(12003,102,5560,'2001-09-13',502);
insert into orders values(12004,105,1500,'2001-10-12',504);
insert into orders values(12005,104,5500,'2001-11-12',505);

===============
Bill
===============	
create table bill(Billid integer Primary key,
Amount integer,
paidstatus varchar(10) Not null);

insert into bill values(1290909,4500,'paid');
insert into bill values(13343332,5500,'pending');	
insert into bill values(2321312312,1500,'paid');
insert into bill values(5290909,4460,'paid');
insert into bill values(6290909,45700,'pending');


===============
payment_detail
===============	
create table payment_detail(paymentid integer Primary key,
Billid integer references bill(Billid),
Amount integer,
date date);

insert into payment_detail values(1,1290909,4500,'2001-08-12');
insert into payment_detail values(2,23213312,1500,'2001-08-12');
insert into payment_detail values(3,5290909,4460,'2001-08-12');

====================
Update operations
====================
update bill set amount=1000 where billid=13343332;

====================
Trigger
====================
DELIMITER $$
USE TCD_SOCS $$
create definer = Current_user trigger 
customer_before_delete
Before delete on customer for each row
BEGIN
DELETE FROM customer WHERE customer.customerid=OLD.customerid;
update orders set customerid=NULL where customerid=OLD.customerid; 
end$$

====================
View
====================
-- Creating a view for order information with customer details
CREATE OR REPLACE VIEW Cust_ord_view AS
SELECT
    O.OrderID,
    O.Order_Date,
    O.Total_Cost,
    C.Name AS CustomerName,
    C.Address AS CustomerAddress
FROM
    Orders O
JOIN
    Customer C ON O.CustomerID = C.CustomerID;