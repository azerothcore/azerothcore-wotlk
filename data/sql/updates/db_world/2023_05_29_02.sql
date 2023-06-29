-- DB update 2023_05_29_01 -> 2023_05_29_02
-- Hellfire Beacons
UPDATE `gameobject_template` SET `ScriptName` = 'go_beacon' WHERE `entry` IN (181579, 181580, 181581);
