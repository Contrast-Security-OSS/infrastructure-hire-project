
select customernumber, customername
from   customers
where  exists( select ordernumber, sum(priceeach * quantityordered)
               from        orderdetails
               inner  join orders using (ordernumber)
               where  customernumber = customers.customernumber
               group  by ordernumber
               having sum(priceeach * quantityordered) > 60000
             );

