-- DB update 2020_05_16_00 -> 2020_05_17_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2020_05_16_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2020_05_16_00 2020_05_17_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1586784089061059200'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1586784089061059200');

DELETE FROM `gameobject_template` WHERE `entry` = 30;
INSERT INTO `gameobject_template` (`entry`, `type`, `displayId`, `name`, `IconName`, `castBarCaption`, `unk1`, `size`, `Data0`, `Data1`, `Data2`, `Data3`, `Data4`, `Data5`, `Data6`, `Data7`, `Data8`, `Data9`, `Data10`, `Data11`, `Data12`, `Data13`, `Data14`, `Data15`, `Data16`, `Data17`, `Data18`, `Data19`, `Data20`, `Data21`, `Data22`, `Data23`, `AIName`, `ScriptName`, `VerifiedBuild`) VALUES 
(30, 8, 0, 'Dalaran Forge Spell Focus', '', '', '', 1, 3, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '', 0);

DELETE FROM `gameobject` WHERE `guid` IN (5271,5272,5273);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `ScriptName`, `VerifiedBuild`) VALUES 
(5271, 30, 571, 0, 0, 1, 1, 5926.17, 689.462, 644.254, 5.85726, -0, -0, -0.211358, 0.977409, 300, 0, 1, '', 0),
(5272, 30, 571, 0, 0, 1, 1, 5912.04, 683.537, 645.332, 0.842481, -0, -0, -0.408893, -0.912582, 300, 0, 1, '', 0),
(5273, 30, 571, 0, 0, 1, 1, 5904.01, 672.677, 645.549, 3.96365, -0, -0, -0.916711, 0.39955, 300, 0, 1, '', 0);

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
