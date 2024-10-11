-- DB update 2022_03_06_03 -> 2022_03_06_04
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2022_03_06_03';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2022_03_06_03 2022_03_06_04 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1645633842238335100'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1645633842238335100');

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=14 AND `SourceGroup` IN (7389, 7398, 7400);
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=14 AND `SourceGroup`=7399 AND `SourceEntry` IN (8865, 8892);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(14, 7398, 8862, 0, 0, 8, 0, 9506, 0, 0, 0, 0, 0, "", "Show gossip text 8862 if quest A Small Start is rewarded"),
(14, 7398, 8862, 0, 0, 8, 0, 9537, 0, 0, 1, 0, 0, "", "Show gossip text 8862 if quest Show Gnomercy is not rewarded"),
(14, 7398, 8862, 0, 0, 16, 0, 1024, 0, 0, 0, 0, 0, "", "Show gossip text 8862 if player is Draenei"),
(14, 7398, 8863, 0, 0, 8, 0, 9506, 0, 0, 0, 0, 0, "", "Show gossip text 8862 if quest A Small Start is rewarded"),
(14, 7398, 8863, 0, 0, 8, 0, 9537, 0, 0, 1, 0, 0, "", "Show gossip text 8862 if quest Show Gnomercy is not rewarded"),
(14, 7398, 8863, 0, 0, 16, 0, 1024, 0, 0, 1, 0, 0, "", "Show gossip text 8862 if player is not Draenei"),
(14, 7398, 8893, 0, 0, 8, 0, 9537, 0, 0, 0, 0, 0, "", "Show gossip text 8893 if quest Show Gnomercy is rewarded"),
(14, 7399, 8865, 0, 0, 8, 0, 9506, 0, 0, 0, 0, 0, "", "Show gossip text 8865 if quest A Small Start is rewarded"),
(14, 7399, 8865, 0, 0, 8, 0, 9537, 0, 0, 1, 0, 0, "", "Show gossip text 8865 if quest Show Gnomercy is not rewarded"),
(14, 7399, 8892, 0, 0, 8, 0, 9537, 0, 0, 0, 0, 0, "", "Show gossip text 8892 if quest Show Gnomercy is rewarded"),
(14, 7400, 8868, 0, 0, 8, 0, 9506, 0, 0, 0, 0, 0, "", "Show gossip text 8868 if quest A Small Start is rewarded"),
(14, 7400, 8868, 0, 0, 8, 0, 9537, 0, 0, 1, 0, 0, "", "Show gossip text 8868 if quest Show Gnomercy is not rewarded"),
(14, 7400, 8892, 0, 0, 8, 0, 9537, 0, 0, 0, 0, 0, "", "Show gossip text 8892 if quest Show Gnomercy is rewarded"),
(14, 7389, 8893, 0, 0, 8, 0, 9537, 0, 0, 0, 0, 0, "", "Show gossip text 8893 if quest Show Gnomercy is rewarded");

DELETE FROM `gossip_menu` WHERE `MenuID` IN (7389, 7398, 7399, 7400) AND `TextID` IN (8863, 8892, 8893);
INSERT INTO `gossip_menu` (`MenuID`, `TextID`) VALUES
(7389, 8893),
(7398, 8863),
(7398, 8893),
(7399, 8892),
(7400, 8892);

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2022_03_06_04' WHERE sql_rev = '1645633842238335100';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
