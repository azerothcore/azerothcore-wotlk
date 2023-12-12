-- DB update 2023_12_12_01 -> 2023_12_12_02
--
UPDATE `creature_template` set `mechanic_immune_mask`=`mechanic_immune_mask`&~(64|1024) WHERE `entry` = 22056;
