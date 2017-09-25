-- ------------- max() 优化
explain select max(pament_date) from payment;
-- 假如说这个表有十万行，他的执行计划会全部查询，大概0.1s左右


-- 优化后
create INDEX index_paydate on payment(pament_date);
explain select max(pament_date) from payment;

select count(movie_ceatetime = 2016 or null ) as '2016年电影',
       count(movie_ceatetime = 2017 or null ) as '2017年电影'
from film;

-- ---------------------------------------子查询优化为连接查询是需要注意一对多的关系
select id from tableName_1 as t1 join tableName_2 on t1.id = t2.id;

-- 使用distinct或者作用查询优化
select distinct id from tableName_1 as t1      join tableName_2 on t1.id = t2.id;
select          id from tableName_1 as t1 LEFT join tableName_2 on t1.id = t2.id;


-- -------------------groupBy的相关优化----------------

-- 优化前 --通过执行计划可以看出优化前使用了临时表和全部排序
EXPLAIN SELECT actor.first_name , actor.last_name ,count(*)
       FROM sakila.film_actor
       INNER JOIN sakila.actor USING (actor_id)
       GROUP BY film_actor.actor_id;

-- 优化后 --通过执行计划可以看出优化后--没有使用了--临时表和--全部排序
EXPLAIN SELECT actor.first_name , actor.last_name ,c.cnt
        FROM sakila.film_actor
               INNER JOIN (
                      select actor_id ,count(*) as cnt from sakila.film_actor
                      GROUP BY actor_id
                      ) as c
               USING (actor_id);

-- -----------------------orderBy相关优化--------------------  -

-- 执行计划显示使用表扫描的方式，使用了文件排序的方式  --全表行数
select * from table_name ORDER BY col_non_key LIMIT 50000,5;

-- 优化01--使用主键或者索引进行排序 -- 500005万行
select * from table_name ORDER BY col_id LIMIT 50000,5;

-- 优化01--使用主键或者索引进行排序 -- 5行 --注意ID间断的问题
select * from table_name WHERE col_id>50000 and col_id <=50005 ORDER BY col_id LIMIT 1,5;











