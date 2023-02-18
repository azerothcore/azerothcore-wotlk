-- DB update 2022_09_19_04 -> 2022_09_19_05
--
UPDATE `creature_template` SET `flags_extra`=`flags_extra`|0x02000000 WHERE `entry`=13996;
