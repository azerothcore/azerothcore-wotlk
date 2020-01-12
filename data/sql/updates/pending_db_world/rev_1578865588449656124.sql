INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1578865588449656124');

UPDATE `creature` SET `spawndist` = 5, `MovementType` = 1 WHERE `guid` IN (96069,96100);
UPDATE `creature_addon` SET `bytes1` = 0 WHERE `guid` IN (96069,96100);

UPDATE `creature` SET `spawndist` = 0, `MovementType` = 0 WHERE `id` = 26369 AND `guid` IN (SELECT `guid` FROM `creature_addon` WHERE `bytes1` = 1);
