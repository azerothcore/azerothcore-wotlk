-- DB update 2025_06_12_00 -> 2025_06_12_01
--
UPDATE `creature_template` SET `flags_extra` = `flags_extra`|2147483648 WHERE `entry` IN (29311, 31464);
