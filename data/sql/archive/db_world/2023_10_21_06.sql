-- DB update 2023_10_21_05 -> 2023_10_21_06
--
DELETE FROM `creature_addon` WHERE `guid` = 135692;
DELETE FROM `waypoint_data` WHERE `id` = 1356920;
UPDATE `creature` SET `MovementType` = 1 WHERE `guid` = 135692;
