-- DB update 2023_01_07_01 -> 2023_01_07_02
--
UPDATE `creature_template` SET `flags_extra`=`flags_extra`|0x00000200 WHERE `entry` IN (17536,18432);
