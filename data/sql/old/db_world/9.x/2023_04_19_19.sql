-- DB update 2023_04_19_18 -> 2023_04_19_19
-- translation error
UPDATE `acore_string` SET `locale_zhCN` = '事件 %u: %s%s\n开始时间: %s 结束时间: %s 发生: %s 全程（长度）: %s\n下一次状态改变: %s' WHERE `entry` = 586;
