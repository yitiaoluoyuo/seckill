

use db_name;-- 使用该数据库

show tables;-- 查询数据库的表

show VARIABLES LIKE '%***%';-- 查询相关设置的状态

EXPLAIN SELECT * from table_name;-- 查看SQL的执行过程，例如：有没有使用索引

show CREATE TABLE table_name; -- 查看建表语句

set names gbk;-- 设置客户端汉子的的编码格式

show columns from table_name; -- 查询表结构

DESC tdb_goods;-- 查看tdb_goods的数据表结构

select distinct * from table_name ;-- distinct 去重

DELIMITER $$ -- console ; 转换为 $$ -- 一般用于存储过程，写较为负责的SQL时

select row_count();-- into outParam -- 插入/更新/删除所影响的行数；




-- ---------------------------分组排序----------------------------------
-- 对结果进行分组 [group by {clo_name|position} [asc|desc],...]
select * FROM table_name group by clo_name_poisition asc;

-- 添加分组条件 [having where_condition]
select sex,age from table_name group by sex having age > 25;
select sex from table_name group by sex having count(age>=25) > 100;

-- 对分组结果排序
select * from table_name order by age,id desc;

-- -----------------------限制查询结果返回的数量---------------------------
-- [ limit { [offset,] row_count | row_count OFFSET offset  } ]
select * from table_name limit 2,2; -- 返回第3-4行数据
select * from table_name limit 2; -- 返回第1-1行数据
select * from table_name order by age,id desc limit 2, 2; -- 返回第3-4行数据,与ID无关