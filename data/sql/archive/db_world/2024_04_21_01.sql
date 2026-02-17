-- DB update 2024_04_21_00 -> 2024_04_21_01
-- add missing script to some fire places
-- Campfire
UPDATE `gameobject_template` SET `ScriptName` = 'go_flames' WHERE (`entry` = 177324);

-- Burning Embers
UPDATE `gameobject_template` SET `ScriptName` = 'go_flames' WHERE (`entry` BETWEEN 3832 AND 3838);
