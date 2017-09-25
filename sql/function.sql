

-- ------------------字符函数----------------------
-- 字符连接
select concat(first_name,last_name) as full_name from testTable;
-- 使用指定的分隔符进行字符连接
select concat_ws('-','a','b','c'); -- a-b-c
-- 数字格式化
select format(1256325.2563,3); -- 1,256,325.256
-- 大小写转换
select lower(MySQL); -- 全部小写
select upper(MySQL); -- 全部大写
-- 获取左侧/右侧字符
select lower(left("MySql",2));
select lower(right("MySql",3));
-- 获取字符串长度
select length('');
-- 删除字符串前后的空格或者字符
select ltrim("  sdf      ");
select rtrim("  sdf      ");
select trim("  sdf      ");
select trim(leading 'a' FROM 'aabbaaa' ); -- bbaaa
select trim(trailing 'a' FROM 'aabbaaa' ); -- aabb
select trim(both 'a' FROM 'aabbaaa' ); -- bb
-- 替换字符
select replace('aabaaba','a','c'); -- ccbccbc 如果c改为空格则达到删除a的效果
-- 截取字符串
select substring('123456789','1','3'); -- 123
select substring('123456789','-1','3'); -- 789
select substring('123456789','8'); -- 89
-- 模式匹配 '%'代表任意个数的字符   '-'代表一个字符
select * from testTable where first_name like '%o%'; -- 查询first_name中包含o的信息
select * from testTable where first_name like '%1%%' ESCAPE '1'; -- 查询first_name中包含%的信息



-- -------------------------数值运算符与函数------------------
-- 四舍五入
select round(5.265,2); -- 5.27
-- 向下取整
select floor(3.99999); -- 3
-- 进一取整/向上取整
select ceil(3.0001); -- 4
-- 幂运算
select pow(2,3); -- 8
-- 数字截断
select truncate(125.265,1); -- 125.2 剩余一位小数
select truncate(125.265,-1); -- 120
-- ----数值运算符-------
-- 整数除法
select 3/4 ; -- 0.75
select 3 div 4 ; -- 0
-- 取余数/取摩
select 5 mod 3 ; -- 2
select 5.2 mod 3 ; -- 2.2

-- 几组数据的最小值
SELECT least(salary-low,high-low,500-56);



-- --------------------比较运算符与函数-----------------------------------
-- 【不】在范围***and****中
select 5 not between 1 and 4; -- 1
-- 【不】在列出值范围内 in（）
select 5 not in (1,6,8,9); -- 1
-- 【不】是null
select '' is not null ;  -- 1
select null is null ;  -- 1
select * from textTable where first_name is not null ;



-- -------------日期时间函数------------------------
-- 当前时间和时间
select now();
-- 当前日期
select curdate();
-- 当前时间
select curtime();
-- 日期变化
select date_add('2017-09-23',interval 365 day ); -- 日期加365天
select date_add('2017-09-23',interval -365 day ); -- 日期减365天
select date_add('2017-09-23',interval 1 year); -- 日期加一年
select date_add('2017-09-23',interval 2 week); -- 日期加2周
-- 日期间的差值
select datediff('2017-09-23','2016-09-23'); -- 365
-- 日期格式转换
select date_format('2017-9-2','%m-%d-%Y'); -- 09-02-2017



-- -----------------------信息函数------------------
-- 连接ID
select connection_id();
-- 当前数据库
select database();
-- 最后插入数据库表的那一行的ID
select last_insert_id();
-- 当前用户
select user();
-- 版本信息
select version();



-- --------------------聚合函数----------------------
-- 平均值
select avg(goods_price) from table_goods;
select round(avg(goods_price),2) from table_goods;
-- 最大值
select max(goods_price) from table_goods;
-- 最小值
select min(goods_price) from table_goods;
-- 计数
select count(goods_id) from table_goods; -- 总共有多少个goods_id
-- 求和
select sum(goods_price) from table_goods;



-- --------------------加密函数-------------------------
-- 信息摘要算法 一般用于web页面
select md5('admin');
-- 密码算法
select password('admin');
set password = password('45*89');















