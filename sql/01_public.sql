create schema public
  
create table public.products(
	product_id varchar(20),
	product_brand varchar(300),
	category varchar(100),
	sub_category varchar(100)
)

create table public.sales
(
    transaction_id integer,
    transactional_date timestamp,
    product_id character varying,
    customer_id integer,
    payment character varying,
    credit_card bigint,
    loyalty_card character varying,
    cost character varying,
    quantity integer,
    price numeric,
    PRIMARY KEY (transaction_id)
)

create table public.date_dim (
    date_key            int not null,
    date                date not null,
    weekday             varchar(9) not null,
    weekday_num         int not null,
    day_month           int not null,
    day_of_year         int not null,
    week_of_year        int not null,
    iso_week            char(10) not null,
    month_num           int not null,
    month_name          varchar(9) not null,
    month_name_short    char(3) not null,
    quarter             int not null,
    year                int not null,
    first_day_of_month  date not null,
    last_day_of_month   date not null,
    yyyymm              char(7) not null,
    weekend_indr        char(10) not null
)

alter table public.date_dim
add constraint date_dim_pk primary key (date_key)

create index d_date_date_actual_idx
    on public.date_dim (date)

insert into public.date_dim (
    date_key,
    date,
    weekday,
    weekday_num,
    day_month,
    day_of_year,
    week_of_year,
    iso_week,
    month_num,
    month_name,
    month_name_short,
    quarter,
    year,
    first_day_of_month,
    last_day_of_month,
    yyyymm,
    weekend_indr
)
select
    to_char(datum, 'yyyymmdd')::int as date_key,
    datum as date,
    to_char(datum, 'tmday') as weekday,
    extract(isodow from datum)::int as weekday_num,
    extract(day from datum)::int as day_month,
    extract(doy from datum)::int as day_of_year,
    extract(week from datum)::int as week_of_year,
    extract(isoyear from datum) || to_char(datum, '"-w"iw-') || extract(isodow from datum) as iso_week,
    extract(month from datum)::int as month_num,
    to_char(datum, 'tmmonth') as month_name,
    to_char(datum, 'mon') as month_name_short,
    extract(quarter from datum)::int as quarter,
    extract(year from datum)::int as year,
    datum + (1 - extract(day from datum))::int as first_day_of_month,
    (date_trunc('month', datum) + interval '1 month - 1 day')::date as last_day_of_month,
    concat(to_char(datum, 'yyyy'), '-', to_char(datum, 'mm')) as yyyymm,
    case
        when extract(isodow from datum) in (6, 7) then 'weekend'
        else 'weekday'
    end as weekend_indr
from (
    select
        '2010-01-01'::date + gs.day as datum
    from generate_series(0, 7300) as gs(day)
) dq
order by date_key


