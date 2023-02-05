-- DB update 2022_10_06_04 -> 2022_10_06_05
--
UPDATE `creature_template` SET `flags_extra`=`flags_extra`|0x02000000 WHERE `entry` IN (15341,14834,11380,12460);
