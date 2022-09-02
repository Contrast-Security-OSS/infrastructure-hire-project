
select customerName, city, orderNumber, orderDate, productCode, quantityOrdered, priceEach
from   customers    as c
join   orders       as o  using (customerNumber)
join   orderdetails as oe using (orderNumber)
where  country = 'Norway'
and    quantityOrdered between 20 and 30;
