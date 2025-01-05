-- DB update 2025_01_05_01 -> 2025_01_05_02

DELETE FROM `creature_template_movement` WHERE `CreatureId` IN (25817, 25748);

UPDATE `creature` SET `MovementType` = 0, `wander_distance` = 0 WHERE `id1` IN (25817, 25748);
-- set to 'sitting'
UPDATE `creature_template_addon`SET `bytes1` = 1 WHERE `entry` IN (25817, 25748);
