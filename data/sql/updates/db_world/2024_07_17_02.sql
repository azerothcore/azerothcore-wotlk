-- DB update 2024_07_17_01 -> 2024_07_17_02
--
UPDATE `creature_template` SET `unit_flags` = `unit_flags`|256|131072 WHERE (`entry` = 17578);
