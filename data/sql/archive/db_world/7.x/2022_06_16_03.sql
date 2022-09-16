-- DB update 2022_06_16_02 -> 2022_06_16_03
--
UPDATE `creature_template` SET `unit_flags`=`unit_flags`|33554432,`flags_extra`=`flags_extra`|2 WHERE `entry`=13148;

