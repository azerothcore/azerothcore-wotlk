-- DB update 2022_05_01_00 -> 2022_05_01_01
--
UPDATE `creature_template` SET `flags_extra`=`flags_extra`|0x20000000 WHERE `entry`=8236;
