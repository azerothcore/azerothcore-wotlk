-- DB update 2022_06_30_00 -> 2022_07_01_00
--
-- Mar'li - Gri'lek
UPDATE `creature_template` SET `flags_extra`=`flags_extra`&~256 WHERE `entry` = 14510;
