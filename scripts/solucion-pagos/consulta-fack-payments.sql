-- Usa la base de datos de la bodega
use sakila_datawh;

-- Paso 1: join de la estrella
with datos as (

    select
        -- datos de los hechos 
        fact.amount,
        -- dimensiones
        dim_customer.*,
        dim_date.*,
        dim_staff.*,
        dim_store.* 

    -- de la tabla de hechos
    from fact_payments as fact

        -- join con las dimensiones de la estrella
        left join dim_customer
            on fact.customer_key = dim_customer.customer_key
        left join dim_date
            on fact.date_key = dim_date.date_key
        left join dim_staff
            on fact.staff_key = dim_staff.staff_key
        left join dim_store
            on fact.store_key = dim_store.store_key
),
-- Paso 2: ventas por mes (consulta)
ventas_por_mes as (
    select 
        sum(amount) ventas,
        store_city ciudad,
        customer_city ciudad_cliente,
        year4,
        month_number
    from datos
    group by 
        ciudad,
        ciudad_cliente,
        year4,
        month_number
)
-- Paso 3: pivote de la tabla y agrupar las variables (solo las que no estan agrupadas)
,ventas_por_mes_pivote as(
select 
    ciudad,
    ciudad_cliente,
    sum(if( year4=2005 and month_number=6, ventas, 0)) as mes_6,
    sum(if( year4=2005 and month_number=7, ventas, 0)) as mes_7
from   
    ventas_por_mes
group by
    ciudad,
    ciudad_cliente

)
-- Paso 4: operaciones sobre las columnas a elegir
select 
    ciudad,
    ciudad_cliente,
    mes_6,
    mes_7,
    (mes_7 - mes_6) as diferencia,
    ((mes_7 - mes_6)/mes_6*100) as pct_inc
from    
    ventas_por_mes_pivote
limit 10
;