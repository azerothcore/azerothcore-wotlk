-- DB update 2025_01_07_03 -> 2025_01_09_00

-- Delete Tanzar
DELETE FROM `creature` WHERE `id1` = 23790 AND (`guid` IN (89157));
DELETE FROM `creature_addon` WHERE (`guid` IN (89157));

-- Set use group loot rules
UPDATE `gameobject_template` SET `Data15` = `Data15`|1 WHERE (`entry` = 186648);
