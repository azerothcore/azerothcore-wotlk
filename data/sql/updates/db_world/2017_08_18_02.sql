-- DB update 2017_08_18_01 -> 2017_08_18_02
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2017_08_18_01';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2017_08_18_01 2017_08_18_02 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1499115152422618300'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--
INSERT INTO version_db_world (`sql_rev`) VALUES ('1499115152422618300');

UPDATE `quest_template_addon` SET `SpecialFlags` = '0' WHERE `ID` = '338';
UPDATE `quest_template_addon` SET `SpecialFlags` = '0' WHERE `ID` = '339';
UPDATE `quest_template_addon` SET `SpecialFlags` = '0' WHERE `ID` = '340';
UPDATE `quest_template_addon` SET `SpecialFlags` = '0' WHERE `ID` = '341';
UPDATE `quest_template_addon` SET `SpecialFlags` = '0' WHERE `ID` = '342';--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
