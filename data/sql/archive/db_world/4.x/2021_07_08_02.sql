-- DB update 2021_07_08_01 -> 2021_07_08_02
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_07_08_01';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_07_08_01 2021_07_08_02 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1625500923667306000'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1625500923667306000');

/* Add new gossip */
DELETE FROM `npc_text` WHERE (`ID` = 50031);
INSERT INTO `npc_text`(`ID`,`text0_0`,`text0_1`,`BroadcastTextID0`,
`lang0`,`Probability0`)
VALUES
(50031,
"Alas $N, I am much too busy to talk. As I mentioned, I need time to think on the situation at hand.$B$BI wish you luck in your travels. Good day.",
"Alas $N, I am much too busy to talk. As I mentioned, I need time to think on the situation at hand.$B$BI wish you luck in your travels. Good day.",0,0,0);

/* Create new gossip menuID */
DELETE FROM `gossip_menu` WHERE (`MenuID` = 61023) AND (`TextID` IN (15296, 50031));
INSERT INTO `gossip_menu` (`MenuID`, `TextID`) VALUES
(61023, 15296),
(61023, 50031);

/* Add condition for the second gossip */
/*
	SourceTypeOrReferenceId = CONDITION_SOURCE_TYPE_GOSSIP_MENU = 14
	ConditionTypeOrReference = CONDITION_QUESTREWARDED = 8
    ConditionValue1(quest_template id) = 8336
    ConditionValue2 - always 0
    ConditionValue3 - always 0
*/
DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId` = 14) AND (`SourceGroup` = 61023) AND (`SourceEntry` = 50031) AND (`SourceId` = 0) AND (`ElseGroup` = 0) AND (`ConditionTypeOrReference` = 8) AND (`ConditionTarget` = 0) AND (`ConditionValue1` = 8336) AND (`ConditionValue2` = 0) AND (`ConditionValue3` = 0);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(14, 61023, 50031, 0, 0, 8, 0, 8336, 0, 0, 0, 0, 0, '', 'Show gossip only if quest 8336 is rewarded');

/* Link creature_template with new gossip menuID */
UPDATE `creature_template` SET `gossip_menu_id` = 61023 WHERE (`entry` = 15296);

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_07_08_02' WHERE sql_rev = '1625500923667306000';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
