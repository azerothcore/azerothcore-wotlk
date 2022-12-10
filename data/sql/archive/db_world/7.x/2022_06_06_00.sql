-- DB update 2022_06_04_00 -> 2022_06_06_00
--
UPDATE `creature_template` SET `flags_extra`=`flags_extra`|256 WHERE `entry`=15082;
