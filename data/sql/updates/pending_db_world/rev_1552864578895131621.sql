INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1552864578895131621');

DELETE FROM `creature_template_addon` WHERE `entry` = 24747;
DELETE FROM `creature_addon` WHERE `guid` IN (SELECT `guid` FROM `creature` WHERE `id` = 24747 AND `MovementType` = 0);
INSERT INTO `creature_addon` (`guid`,`bytes1`) SELECT `guid`, 1 as `bytes1` FROM `creature` WHERE `id` = 24747 AND `MovementType` = 0;

UPDATE `creature` SET `spawndist` = 5, `MovementType` = 1 WHERE `id` = 24746;
