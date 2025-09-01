-- DB update 2023_07_10_02 -> 2023_07_10_03
--
UPDATE `creature_template` SET `mechanic_immune_mask` = `mechanic_immune_mask`&~(64|2048|536870912) WHERE `entry` = 17454;
