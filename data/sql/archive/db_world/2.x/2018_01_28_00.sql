-- DB update 2018_01_21_00 -> 2018_01_28_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2018_01_21_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2018_01_21_00 2018_01_28_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1516149942175144200'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO version_db_world (`sql_rev`) VALUES ('1516149942175144200');

-- Useless loot
DELETE FROM `creature_loot_template` WHERE `entry` IN (1, 1175);
-- Conditions for lootid 1, useless
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 1 AND `SourceGroup` = 1;

-- Attumen the Huntsman - Fix condition on item 23809
UPDATE `conditions` SET `SourceGroup` = 16152 WHERE `SourceGroup` = 15550 AND `SourceEntry` = 23809;

-- Conditions that aren't referenced and, still, aren't correct.
DELETE FROM `conditions` WHERE `SourceGroup` = 21060 AND `SourceEntry` = 23612;
DELETE FROM `conditions` WHERE `SourceGroup` = 21061 AND `SourceEntry` = 23612;

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
