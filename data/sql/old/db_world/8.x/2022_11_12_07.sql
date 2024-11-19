-- DB update 2022_11_12_06 -> 2022_11_12_07
--
UPDATE `creature_template` SET `flags_extra`=`flags_extra`|33554432 WHERE `entry` IN (17280, 18059);
