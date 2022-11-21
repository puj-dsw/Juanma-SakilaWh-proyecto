insert into sakila_datawh.fact_payments (
    customer_key,
    staff_key,
    store_key,
    date_key,
    amount,
    payment_id
)

SELECT dim_customer.customer_key,
dim_staff.staff_key,
dim_store.store_key, 
TO_DAYS(payment.payment_date) as date_key,

payment.amount,
payment.payment_id


FROM sakila.payment as payment
LEFT JOIN sakila_datawh.dim_customer as dim_customer 
on payment.customer_id=dim_customer.customer_id 

LEFT JOIN sakila_datawh.dim_staff as dim_staff 
on payment.staff_id=dim_staff.staff_id 

LEFT JOIN sakila.rental as rental 
on payment.rental_id=rental.rental_id 

LEFT JOIN sakila.inventory as inventory
on rental.inventory_id=inventory.inventory_id 

LEFT JOIN sakila_datawh.dim_store as dim_store 
on inventory.store_id=dim_store.store_id 

where store_key is not null
;