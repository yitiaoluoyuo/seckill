-- --------------------索引-------------------------------

-- 创建索引
CREATE INDEX indexName ON mytable(username(20));


-- 删除索引
alter table  table_name drop INDEX `index_name`;

ALTER TABLE table_name ADD INDEX `btree_INDEX` USING HASH (`cname1`,`cname2`);



-- 创建无索引的表格
create table testNoPK (
  id int not null,
  name varchar(10)
);
-- 创建普通索引
create index IDX_testNoPK_Name USING BTREE on testNoPK (name);



-- 1.添加PRIMARY KEY（主键索引）
ALTER TABLE `table_name` ADD PRIMARY KEY ( `column` );

-- 2.添加UNIQUE(唯一索引)
ALTER TABLE `table_name` ADD UNIQUE ( `column`);

-- 3.添加INDEX(普通索引)
ALTER TABLE `table_name` ADD INDEX index_name ( `column` );

-- 4.添加FULLTEXT(全文索引)
ALTER TABLE `table_name` ADD FULLTEXT ( `column`);

-- 5.添加多列索引
ALTER TABLE `table_name` ADD INDEX index_name USING BTREE ( `column1`, `column2`, `column3` );