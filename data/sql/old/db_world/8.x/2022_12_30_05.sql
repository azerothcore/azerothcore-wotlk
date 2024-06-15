-- DB update 2022_12_30_04 -> 2022_12_30_05
--
UPDATE `creature_template` SET `flags_extra`=`flags_extra`|130 WHERE `entry`=31874;

