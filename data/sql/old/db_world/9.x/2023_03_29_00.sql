-- DB update 2023_03_28_03 -> 2023_03_29_00
--
UPDATE `creature_template` SET `flags_extra`=`flags_extra`|128 WHERE `entry`=21944;
