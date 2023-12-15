
select employeeNumber, lastName, firstName, revenue
from   employees as e
join   (
          select salesRepEmployeeNumber, c.customerNumber
          from   customers as c
          join   orders    as o on (c.customerNumber = o.customerNumber)
          where  c.creditlimit > 50000
       ) as cust_ord on (e.employeeNumber = cust_ord.salesRepEmployeeNumber)
join   (
          select o.ordernumber, customerNumber, od.productcode
          from   orders       as o
          join   orderdetails as od using (ordernumber)
          where  o.status     like '%Shipped%'
       ) as ords on (cust_ord.customerNumber = ords.customerNumber)
join   (
          select p.productCode, sum( od.priceeach - p.buyPrice) as revenue
          from   products     as p
          join   orderdetails as od using (productcode)
          group  by 1
          having revenue > 1500
       ) as rev on (rev.productCode = ords.productCode)
;
