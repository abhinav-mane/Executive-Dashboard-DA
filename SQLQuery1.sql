USE BikeStores;

-- ANALYSIS OF WHAT WE HAVE AS OF NOW

select * from production.brands;

select * from production.categories;

select * from production.products;

select * from production.stocks;

-- sales side of data 

select * from sales.customers;

select * from sales.order_items;

select * from sales.orders;

select * from sales.staffs;

select * from sales.stores;

-- Lets get the data in one place using a join first

select 
		ord.order_id,
		CONCAT(cus.first_name,' ' ,cus.last_name) as Full_name,
		cus.city,
		cus.state,
		ord.order_date,
		SUM(ite.quantity) as total_units,
		SUM(ite.quantity * ite.list_price) as revenue,
		pro.product_name,
		cat.category_name,
		sto.store_name,
		CONCAT(sta.first_name,' ',sta.last_name) as Staff_Rep_Name

from sales.orders as ord

JOIN sales.customers as cus
ON ord.customer_id = cus.customer_id

JOIN sales.order_items as ite
ON ord.order_id = ite.order_id

JOIN production.products as pro
ON ite.product_id = pro.product_id

JOIN production.categories as cat
ON pro.category_id = cat.category_id

JOIN sales.stores as sto
ON ord.store_id = sto.store_id

JOIN sales.staffs as sta
on ord.staff_id = sta.staff_id

GROUP BY 
		ord.order_id,
		CONCAT(cus.first_name,' ' ,cus.last_name),
		cus.city,
		cus.state,
		ord.order_date,
		pro.product_name,
		cat.category_name,
		sto.store_name,
		CONCAT(sta.first_name,' ',sta.last_name);