create schema staging

create table staging.stg_products(
	product_id varchar(20),
	product_brand varchar(300),
	category varchar(100),
	sub_category varchar(100)
)

create table staging.sales
(
    transaction_id integer,
	transactional_date timestamp,
	product_id character varying,
    customer_id integer,
    payment character varying,
    credit_card bigint,
    loyalty_card character varying,
    cost numeric,
    quantity integer,
    price numeric,
    PRIMARY KEY (transaction_id)
)

select distinct 
	coalesce(payment, 'cash') as payment, 
	loyalty_card 
from staging.sales

select 
	transaction_id ,
	transactional_date ,
	extract(year from transactional_date)*10000 + extract('month' from transactional_date)*100+extract('day' from transactional_date)as 	transactional_date_fk,
	f.product_id ,
	p.product_PK as product_FK,
	payment_PK as payment_FK,
    customer_id ,
    credit_card ,
   	cost ,
    quantity ,
   	price
from staging.sales f
left join  core.dim_payment d on d.payment = coalesce(f.payment,'cash') 
	and d.loyalty_card=f.loyalty_card
left join core.dim_products p on p.product_id=f.product_id
order by product_id
