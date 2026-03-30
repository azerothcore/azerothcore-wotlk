-- DB update 2025_05_10_02 -> 2025_05_10_03
--
UPDATE `spell_proc_event` SET `procFlags` = 0 WHERE `entry` IN (20186, 20185);
