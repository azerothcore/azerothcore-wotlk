-- DB update 2022_06_06_04 -> 2022_06_06_05
--
UPDATE `creature_template` SET `flags_extra`=`flags_extra`|0x00400000 WHERE `entry`=14986;
