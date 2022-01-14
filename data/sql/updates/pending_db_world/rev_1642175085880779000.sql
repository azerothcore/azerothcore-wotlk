INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1642175085880779000');

-- Based on the wrong creatures' position.
-- Left group
UPDATE `creature` SET `position_x` = -7462.55, `position_y` = -1015.27, `position_z` = 408.75, `orientation` = 2.26 WHERE `guid` = 84605;
UPDATE `creature` SET `position_x` = -7484.4, `position_y` = -992.57, `position_z` = 408.74, `orientation` = 2.28 WHERE `guid` = 84606;
UPDATE `creature` SET `position_x` = -7469.89, `position_y` = -1004.51, `position_z` = 408.74, `orientation` = 2.17 WHERE `guid` = 84616;
-- Right group
UPDATE `creature` SET `position_x` = -7505.69, `position_y` = -1007.07, `position_z` = 408.73, `orientation` = 2.19 WHERE `guid` = 84603;
UPDATE `creature` SET `position_x` = -7491.17, `position_y` = -1035.6, `position_z` = 408.74, `orientation` = 2.26 WHERE `guid` = 84614;
UPDATE `creature` SET `position_x` = -7494.95, `position_y` = -1022.22, `position_z` = 408.73, `orientation` = 2.19 WHERE `guid` = 84615;

DELETE FROM `creature` WHERE `guid` IN (84513, 84514, 84515, 84516, 84517, 84518);
