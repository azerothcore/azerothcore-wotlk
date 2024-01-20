-- DB update 2023_03_11_07 -> 2023_03_11_08
-- Starving Helboar
UPDATE `creature_template_addon` SET `auras` = '33908' WHERE `entry` = 16879;
UPDATE `creature_template` SET `AIName` = '', `detection_range` = 30 WHERE `entry` = 16879;
DELETE FROM `smart_scripts` WHERE `source_type` = 0 AND `entryorguid` = 16879;
