-- DB update 2023_04_06_00 -> 2023_04_06_01
DELETE FROM `creature` WHERE (`id1` = 37230) AND (`guid` IN (247157));
DELETE FROM `creature_movement_override` WHERE `SpawnId`=247157;
