-- DB update 2017_10_17_00 -> 2017_10_17_01
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2017_10_17_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2017_10_17_00 2017_10_17_01 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1508171834127824700'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--
INSERT INTO version_db_world (`sql_rev`) VALUES ('1508171834127824700');

-- Warsong Recruitment Officer - Gossip (Hellscream's Vigil)
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=19 AND (`SourceEntry`=11586 OR `SourceEntry`=11585);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceEntry`,`ConditionTypeOrReference`,`ConditionValue1`,`Comment`) VALUES 
(19, 11585, 14, 10172, "Accept quest 11585 - Quest 10172 needs to be incomplete"),
(19, 11586, 8, 10172, "Accept quest 11586 - Quest 10172 needs to be rewarded");

UPDATE `quest_template_addon` SET `ExclusiveGroup`=11585 WHERE `ID` IN (11585,11586);
--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
