-- DB update 2021_09_04_01 -> 2021_09_04_02
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_09_04_01';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_09_04_01 2021_09_04_02 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1629752061588917431'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1629752061588917431');

UPDATE `creature` SET `MovementType` = 1, `wander_distance` = 3  WHERE `id` = 5229 AND (`guid` IN (50173, 50175, 50176, 50177, 50179, 50180));
UPDATE `creature` SET `MovementType` = 1, `wander_distance` = 3  WHERE `id` = 5232 AND (`guid` IN (50194, 50195, 50196, 50198, 50203, 50205, 50206, 50215, 50216, 50217, 50218));
UPDATE `creature` SET `MovementType` = 1, `wander_distance` = 3  WHERE `id` = 5234 AND (`guid` IN (50222, 50227, 50230));
UPDATE `creature` SET `MovementType` = 1, `wander_distance` = 3  WHERE `id` = 5236 AND (`guid` IN (50235, 50244));
UPDATE `creature` SET `MovementType` = 1, `wander_distance` = 3  WHERE `id` = 5237 AND (`guid` IN (50250, 50251, 50252, 50253, 50254));
UPDATE `creature` SET `MovementType` = 1, `wander_distance` = 3  WHERE `id` = 5240 AND (`guid` IN (50291, 50297));
UPDATE `creature` SET `MovementType` = 1, `wander_distance` = 3  WHERE `id` = 5241 AND (`guid` IN (50307, 50313, 50317, 50319));
UPDATE `creature` SET `MovementType` = 1, `wander_distance` = 15 WHERE `id` = 5238 AND (`guid` IN (50268, 50269, 50270));
UPDATE `creature` SET `MovementType` = 1, `wander_distance` = 15 WHERE `id` = 5240 AND (`guid` IN (50294));
UPDATE `creature` SET `MovementType` = 1, `wander_distance` = 15 WHERE `id` = 7584 AND (`guid` IN (50800));
UPDATE `creature` SET `MovementType` = 1, `wander_distance` = 3  WHERE `id` = 5241 AND (`guid` IN (50314));
UPDATE `creature` SET `MovementType` = 1, `wander_distance` = 6  WHERE `id` = 23022 AND (`guid` IN (91738));
UPDATE `creature` SET `MovementType` = 1, `wander_distance` = 6  WHERE `id` = 22148 AND (`guid` IN (91739));
UPDATE `creature` SET `MovementType` = 1, `wander_distance` = 2  WHERE `id` = 22143 AND (`guid` IN (91722, 91744,91746, 91747));
UPDATE `creature` SET `MovementType` = 1, `wander_distance` = 2  WHERE `id` = 22144 AND (`guid` IN (91731, 91740, 91741, 91742, 91748));
UPDATE `creature` SET `MovementType` = 1, `wander_distance` = 2  WHERE `id` = 22148 AND (`guid` IN (91745));
UPDATE `creature` SET `MovementType` = 1, `wander_distance` = 3  WHERE `id` = 22143 AND (`guid` IN (91720,91721));
UPDATE `creature` SET `MovementType` = 1, `wander_distance` = 4  WHERE `id` = 22144 AND (`guid` IN (91719 ,91728));

UPDATE `creature_template` SET `MovementType` = 1 WHERE (`entry` IN (5229,5231,5232,5234,5236,5237,5238,5239,5240,5241,22143,22144,22148,23022));

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_09_04_02' WHERE sql_rev = '1629752061588917431';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
