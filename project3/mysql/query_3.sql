
select employeeNumber, lastName, firstName
from   employees
where  employeeNumber in (
          select employeeNumber
          from   (select salesRepEmployeeNumber as employeeNumber, sum(amount) as TotalAmount
                  from   customers as c
                  join   payments  as p on (c.customerNumber = p.customerNumber)
                  where  year(paymentdate) = 2004
                  group  by salesRepEmployeeNumber
                 ) as pymt
       );

