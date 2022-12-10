-- DB update 2017_09_18_00 -> 2018_04_19_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_characters' AND COLUMN_NAME = '2017_09_18_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_characters CHANGE COLUMN 2017_09_18_00 2018_04_19_00 bit;
SELECT sql_rev INTO OK FROM version_db_characters WHERE sql_rev = '1515873371010860000'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO version_db_characters (`sql_rev`) VALUES ('1515873371010860000');

ALTER TABLE `characters`
	ADD `skin` tinyint(3) unsigned NOT NULL DEFAULT '0' AFTER `money`,
	ADD `face` tinyint(3) unsigned NOT NULL DEFAULT '0' AFTER `skin`,
	ADD `hairStyle` tinyint(3) unsigned NOT NULL DEFAULT '0' AFTER `face`,
	ADD `hairColor` tinyint(3) unsigned NOT NULL DEFAULT '0' AFTER `hairStyle`,
	ADD `facialStyle` tinyint(3) unsigned NOT NULL DEFAULT '0' AFTER `hairColor`,
	ADD `bankSlots` tinyint(3) unsigned NOT NULL DEFAULT '0' AFTER `facialStyle`,
	ADD `restState` tinyint(3) unsigned NOT NULL DEFAULT '0' AFTER `bankSlots`;
	
UPDATE `characters` SET
	`skin` = `playerBytes`&0xFF,
	`face` = (`playerBytes`>>8)&0xFF,
	`hairStyle`=(`playerBytes`>>16)&0xFF,
	`hairColor`=(`playerBytes`>>24)&0xFF,
	`facialStyle`=`playerBytes2`&0xFF,
	`bankSlots`=(`playerBytes2`>>16)&0xFF,
	`restState`=(`playerBytes2`>>24)&0xFF;
	
ALTER TABLE `characters` DROP `playerBytes`, DROP `playerBytes2`;

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
