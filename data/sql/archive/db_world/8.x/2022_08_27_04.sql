-- DB update 2022_08_27_03 -> 2022_08_27_04
--
-- Cleanup on creatures that don't exist
DELETE FROM `creature` WHERE `guid` IN (200616);
DELETE FROM `creature_addon` WHERE `guid` IN (200616);
DELETE FROM `waypoint_data` WHERE `id` IN (2006160);

-- UPDATE id2 on Axe Thrower / Priest spawn
UPDATE `creature` SET `id2`=11350 WHERE `guid`=49105;

-- Snakes that can be set both ways
UPDATE `creature` SET `id1`=11371 WHERE `guid` IN (49101, 49098, 49100, 49099, 51451, 51452);
UPDATE `creature` SET `id2`=11372 WHERE `guid` IN (49101, 49098, 49100, 49099, 51451, 51452);

DELETE FROM `creature_formations` where `leaderGUID`=49101;
-- Link the snakes so they agro together, this should ensure the entire 7 pack agros together while also allowing pooling for the trolls
INSERT INTO `creature_formations` (`leaderGUID`, `memberGUID`, `dist`, `angle`, `groupAI`, `point_1`, `point_2`) VALUES 
(49101, 49101, 0, 0, 3, 0, 0),
(49101, 49098, 0, 0, 3, 0, 0),
(49101, 49100, 0, 0, 3, 0, 0),
(49101, 49099, 0, 0, 3, 0, 0);
