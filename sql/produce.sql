-- 秒杀执行储存过程
DELIMITER $$ -- console ; 转换为
$$ -- 定义开始
-- 定义储存过程
-- 参数： in 参数   out输出参数
-- row_count() 返回上一条修改类型sql(delete,insert,update)的影响行数
-- row_count:0:未修改数据 ; >0:表示修改的行数； <0:sql错误
CREATE PROCEDURE `seckill`.`execute_seckill`(IN v_seckill_id BIGINT,
                                             IN v_phone BIGINT,
                                             IN v_kill_time  TIMESTAMP,
                                             OUT r_result INT)
  BEGIN -- 开始

    DECLARE insert_count INT DEFAULT 0; -- 局部变量，必须在第一行
    START TRANSACTION; -- 开启事务
    INSERT IGNORE INTO success_killed
    (seckill_id, user_phone, create_time)
    VALUES (v_seckill_id, v_phone, v_kill_time);
    SELECT row_count()
    INTO insert_count;
    IF (insert_count = 0)
    THEN
      ROLLBACK; -- 回滚事务
      SET r_result = -1; -- 用户变量 与客户端绑定，
    ELSEIF (insert_count < 0)
      THEN
        ROLLBACK; -- 回滚事务
        SET r_result = -2;
    ELSE
-- --------先插入后更新，减少行级锁的占用时间-----------
      UPDATE seckill
      SET number = number - 1
      WHERE seckill_id = v_seckill_id
            AND end_time > v_kill_time
            AND start_time < v_kill_time
            AND number > 0;
      SELECT row_count()
      INTO insert_count;
      IF (insert_count = 0)
      THEN
        ROLLBACK;
        SET r_result = 0;
      ELSEIF (insert_count < 0)
        THEN
          ROLLBACK; -- 回滚事务
          SET r_result = -2;
      ELSE
        COMMIT; -- 提交事务
        SET r_result = 1;

      END IF;
    END IF;
  END; -- 结束
$$ -- 定义结束



DELIMITER ; -- 重新把 $$ 改为 ;
SET @r_result = -3;


--  执行储存过程
CALL execute_seckill(1003, 13502178891, now(), @r_result);


-- 获取结果
SELECT @r_result;

-- 删除存储过程
DROP PROCEDURE IF EXISTS procedure_name;