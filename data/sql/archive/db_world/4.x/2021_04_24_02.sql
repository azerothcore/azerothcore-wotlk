-- DB update 2021_04_24_01 -> 2021_04_24_02
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_04_24_01';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_04_24_01 2021_04_24_02 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1618957690243395100'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1618957690243395100');

UPDATE `creature_template` SET `npcflag`=`npcflag`|1 WHERE `entry` = 30596;

DELETE FROM `creature_template_addon` WHERE `entry` = 30596;
INSERT INTO `creature_template_addon` (`entry`, `bytes2`) VALUES
(30596, 0);

DELETE FROM `gossip_menu` WHERE `MenuID`=9999 AND `TextID`=13857;
INSERT INTO `gossip_menu` (`MenuID`, `TextID`) VALUES
(9999, 13857);

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=14 AND `SourceGroup`=9999;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(14, 9999, 13856, 0, 0, 15, 0, 32, 0, 0, 1, 0, 0, "", "Show gossip text 13856 if player is NOT a Death Knight"),
(14, 9999, 13857, 0, 0, 15, 0, 32, 0, 0, 0, 0, 0, "", "Show gossip text 13857 if player is a Death Knight");

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
