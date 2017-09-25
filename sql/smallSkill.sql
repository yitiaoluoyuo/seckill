--  ---------------------------查询技巧----------------


-- 查询同一个表中同一个字段不通值作为查询条件 （同一个字段的多值过滤）

-- 查询兴趣爱好有sing和dance和read的会员
SELECT user_name ,info_01.favorite,info_02.favorite,info_03.favorite from users
    JOIN user_info as info_01 on info_01.id = users.id and info_01.favorite = 'dance'
    JOIN user_info as info_02 on info_02.id = users.id and info_02.favorite = 'sing'
    JOIN user_info as info_03 on info_02.id = users.id and info_03.favorite = 'read';


-- 分组查询

-- 查询有两个或者两个以上爱好的用户名。
select user_name from users as u
    join user_info as info on u.id =info.id
    WHERE info.favorite IN ('dance','sing','read','cray','smile','sport','swim')
GROUP BY u.user_name HAVING count(u.user_name) >=2;





-- --------------------------where语句-多条件-过滤--------------


-- 一个人 订单数对多的日期
select u.id ,o.timer,o.order_count FROM users u
    JOIN orders o on u.id = o.id
    WHERE (o.id,o.order_count) IN (SELECT id,max(order_count) from orders GROUP BY id);


-- 通过关联查询进行优化

select u.id ,o.timer,o.order_count FROM users u
  JOIN orders o on u.id = o.id
  join (select id,max(order_count) as cnt from orders GROUP BY id ) as o2
    on o.id = o2.id and o.order_count = cnt ;

-- ---------------------按照税率查询需要交纳的个人所得税-------------------------------

-- 首先查出每个人工资在对应税率区间的--钱数和--对应税率
SELECT user_name, salary, low, high, least(salary-low,high-low) as cur_money, rate from users as u
  join rate_table as r on u.id = r.id where salary>low
  ORDER BY user_name,low;

-- 然后查询出需要缴纳的税金
SELECT user_name,count(cur_money*rate) FROM (
      SELECT user_name, salary, low, high, least(salary-low,high-low) as cur_money, rate from users as u
      join rate_table as r on u.id = r.id where u.salary>r.low
) GROUP BY user_name;























