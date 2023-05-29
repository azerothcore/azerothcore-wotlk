-- DB update 2022_08_21_15 -> 2022_08_21_16
--
UPDATE `creature_template` SET `flags_extra`=`flags_extra`|0x02000000 WHERE `entry` IN (15385,15386,15387,15388,15389,15390,15391,15392,15344);
