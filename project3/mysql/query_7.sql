
select customernumber,
       round(sum(quantityordered * priceeach)) sales,
       (case
           when sum(quantityordered * priceeach) < 10000                  then 'Silver'
           when sum(quantityordered * priceeach) between 10000 and 100000 then 'Gold'
           when sum(quantityordered * priceeach) > 100000                 then 'Platinum'
       end) customergroup
from       orderdetails
inner  join orders using (ordernumber)
where  year(shippeddate) = 2003
group  by customernumber;

