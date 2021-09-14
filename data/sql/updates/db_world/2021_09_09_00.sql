-- DB update 2021_09_08_00 -> 2021_09_09_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_09_08_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_09_08_00 2021_09_09_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1629826555036082700'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1629826555036082700');

ALTER TABLE `creature_loot_template` CHANGE `Reference` `Reference` MEDIUMINT DEFAULT 0 NOT NULL;
ALTER TABLE `disenchant_loot_template` CHANGE `Reference` `Reference` MEDIUMINT DEFAULT 0 NOT NULL;
ALTER TABLE `fishing_loot_template` CHANGE `Reference` `Reference` MEDIUMINT DEFAULT 0 NOT NULL;
ALTER TABLE `gameobject_loot_template` CHANGE `Reference` `Reference` MEDIUMINT DEFAULT 0 NOT NULL;
ALTER TABLE `item_loot_template` CHANGE `Reference` `Reference` MEDIUMINT DEFAULT 0 NOT NULL;
ALTER TABLE `mail_loot_template` CHANGE `Reference` `Reference` MEDIUMINT DEFAULT 0 NOT NULL;
ALTER TABLE `milling_loot_template` CHANGE `Reference` `Reference` MEDIUMINT DEFAULT 0 NOT NULL;
ALTER TABLE `pickpocketing_loot_template` CHANGE `Reference` `Reference` MEDIUMINT DEFAULT 0 NOT NULL;
ALTER TABLE `prospecting_loot_template` CHANGE `Reference` `Reference` MEDIUMINT DEFAULT 0 NOT NULL;
ALTER TABLE `reference_loot_template` CHANGE `Reference` `Reference` MEDIUMINT DEFAULT 0 NOT NULL;
ALTER TABLE `skinning_loot_template` CHANGE `Reference` `Reference` MEDIUMINT DEFAULT 0 NOT NULL;
ALTER TABLE `spell_loot_template` CHANGE `Reference` `Reference` MEDIUMINT DEFAULT 0 NOT NULL;

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_09_09_00' WHERE sql_rev = '1629826555036082700';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
