-- DB update 2023_04_05_03 -> 2023_04_05_04
DELETE FROM `creature` WHERE (`id1` = 37230) AND (`guid` IN (247156));

DELETE FROM `creature_movement_override` WHERE `SpawnId`=247156;
