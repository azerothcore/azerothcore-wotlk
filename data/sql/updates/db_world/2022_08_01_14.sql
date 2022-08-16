-- DB update 2022_08_01_13 -> 2022_08_01_14
--
UPDATE `creature_template` SET `unit_flags`=`unit_flags`|33554432 WHERE `entry`=14459;

