-- DB update 2023_04_26_02 -> 2023_04_26_03
-- Tortured Skeletons flags
UPDATE `creature_template` SET `unit_flags` = `unit_flags`&~33554432 WHERE (`entry` = 20662);
-- Most gameobjects were missing Heroic spawns
UPDATE `gameobject` SET `spawnMask` = `spawnMask`|2 WHERE `map` = 555 AND `id` NOT IN (184196);
