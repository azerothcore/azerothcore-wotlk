INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1625663426005917331');

-- Move 5 ore nodes up by 6 units so they do not spawn underground
UPDATE `gameobject` SET `position_z` = 263.1 WHERE `id` = 1735 AND `guid` = 71090;
UPDATE `gameobject` SET `position_z` = 263.1 WHERE `id` = 2040 AND `guid` = 71091;
UPDATE `gameobject` SET `position_z` = 263.1 WHERE `id` = 1734 AND `guid` = 71092;
UPDATE `gameobject` SET `position_z` = 263.1 WHERE `id` = 1733 AND `guid` = 71093;
UPDATE `gameobject` SET `position_z` = 263.1 WHERE `id` = 2047 AND `guid` = 71094;

