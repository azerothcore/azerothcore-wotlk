-- DB update 2023_06_17_07 -> 2023_06_17_08
--
UPDATE `creature_template` SET `mechanic_immune_mask` = `mechanic_immune_mask`|1|2|8|16|64|1024|2048|4096|8192|65536|8388608|536870912 WHERE `entry`=22930;

