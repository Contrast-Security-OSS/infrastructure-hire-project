
select year(orderdate)                  as year,
       sum(quantityordered * priceeach) as total
from   orders
inner  join orderdetails using (ordernumber)
where  status = 'Shipped'
group  by year
having year > 2003;
