-- DB update 2021_10_19_02 -> 2021_10_20_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_10_19_02';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_10_19_02 2021_10_20_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1634524834761698100'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1634524834761698100');

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 22 AND `SourceEntry` = 182026;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(22, 1, 182026, 1, 0, 29, 1, 17886, 60, 0, 0, 0, 0, '', 'Sun Gate - Only run SAI IF trigger IN RANGE'),
(22, 2, 182026, 1, 0, 29, 1, 17886, 60, 1, 1, 0, 0, '', 'Sun Gate - Only run SAI IF NO trigger IN RANGE');

-- Increase respawn timer to two minutes
UPDATE `creature` SET `spawntimesecs` = 123 WHERE `id` = 17886;
UPDATE `gameobject` SET `spawntimesecs` = 120 WHERE `id` = 184850;

UPDATE `smart_scripts` SET `action_type` = 41, `comment` = 'Sunhawk Portal Controller - On Gameobject State Changed - Despawn Target' WHERE `entryorguid` IN (-12168, -12173, -12164, -12166) AND `source_type` = 1 AND `action_type` = 51;

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_10_20_00' WHERE sql_rev = '1634524834761698100';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
