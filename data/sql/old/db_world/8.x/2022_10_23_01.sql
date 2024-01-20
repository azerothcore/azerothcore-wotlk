-- DB update 2022_10_23_00 -> 2022_10_23_01
--
UPDATE `creature_template` SET `flags_extra`=`flags_extra`|0x00000200 WHERE `entry`=23543;
