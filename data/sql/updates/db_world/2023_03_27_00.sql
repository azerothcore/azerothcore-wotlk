-- DB update 2023_03_25_00 -> 2023_03_27_00
--
UPDATE `creature_template` SET `flags_extra`=`flags_extra`|64|1073741824 WHERE (`entry` IN (20481, 21538));
