INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1567713200326299359');

UPDATE `creature_template` SET `flags_extra`= 0 WHERE `entry` IN (26638,31351);
 
UPDATE `creature_template` SET `faction`= 16  WHERE `entry` IN (26620,31339);

DELETE FROM `creature_addon` WHERE `guid` = 127438;
INSERT INTO `creature_addon` (`guid`, `bytes2`, `emote`) VALUES 
(127438, 1, 36);

DELETE FROM `smart_scripts` WHERE `entryorguid`= 26623  AND `id` IN (10,11);

DELETE FROM `smart_scripts` WHERE `entryorguid` IN (-127591,-127590,-127589,-127582,-127580,-127579,-127578);

DELETE FROM `creature_formations` WHERE `leaderGUID` IN (127590,127580,127449,127579);

INSERT INTO `creature_formations` (`leaderGUID`, `memberGUID`, `dist`, `angle`, `groupAI`, `point_1`, `point_2`) VALUES
(127590, 127590, 0, 0, 3, 0, 0),
(127590, 127438, 0, 0, 3, 0, 0),
(127590, 127617, 0, 0, 3, 0, 0),
(127590, 127589, 0, 0, 3, 0, 0),
(127580, 127580, 0, 0, 3, 0, 0),
(127580, 127427, 0, 0, 3, 0, 0),
(127580, 127428, 0, 0, 3, 0, 0),
(127449, 127449, 0, 0, 3, 0, 0),
(127449, 127451, 0, 0, 3, 0, 0),
(127449, 127591, 0, 0, 3, 0, 0),
(127449, 127582, 0, 0, 3, 0, 0),
(127579, 127579, 0, 0, 3, 0, 0),
(127579, 127578, 0, 0, 3, 0, 0),
(127579, 127432, 0, 0, 3, 0, 0),
(127579, 127433, 0, 0, 3, 0, 0);
