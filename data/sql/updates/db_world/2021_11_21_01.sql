-- DB update 2021_11_21_00 -> 2021_11_21_01
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_11_21_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_11_21_00 2021_11_21_01 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1637425810506169700'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1637425810506169700');

UPDATE `quest_template_addon` SET `ExclusiveGroup` = 0 WHERE `ID` IN (1642, 1646);

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=19 AND `SourceGroup`=0 AND `SourceEntry`=1643 AND `SourceId`=0;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(19, 0, 1643, 0, 0, 47, 0, 1642, 64, 0, 0, 0, 0, '', 'Quest The Tome of Divinity (Human) available if quest The Tome of Divinity (book) has been rewarded.');

UPDATE `quest_template_addon` SET `SpecialFlags` = 1 WHERE `ID` IN (1641, 1645);

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=19 AND `SourceGroup`=0 AND `SourceEntry` IN (1641, 1645) AND `SourceId`=0;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(19, 0, 1641, 0, 0, 47, 0, 1642, 1, 0, 0, 0, 0, '', 'Quest The Tome of Divinity (Human, offer book) available if quest The Tome of Divinity (Human, book) has not been taken.'),
(19, 0, 1645, 0, 0, 47, 0, 1646, 1, 0, 0, 0, 0, '', 'Quest The Tome of Divinity (Dwarf, offer book) available if quest The Tome of Divinity (Dwarf, book) has not been taken.');

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_11_21_01' WHERE sql_rev = '1637425810506169700';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
