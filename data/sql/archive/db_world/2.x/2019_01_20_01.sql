-- DB update 2019_01_20_00 -> 2019_01_20_01
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2019_01_20_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2019_01_20_00 2019_01_20_01 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1547906915621116396'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1547906915621116396');


-- ALTER TABLE CHANGE COLUMN

ALTER TABLE `creature_equip_template`
	CHANGE COLUMN `VerifiedBuild` `VerifiedBuild` smallint(5) DEFAULT '0';

ALTER TABLE `item_set_names`
  CHANGE COLUMN `VerifiedBuild` `VerifiedBuild` smallint(5) DEFAULT '0';

ALTER TABLE `item_template`
  CHANGE COLUMN `VerifiedBuild` `VerifiedBuild` smallint(5) DEFAULT '0';

ALTER TABLE `quest_template`
  CHANGE COLUMN `VerifiedBuild` `VerifiedBuild` smallint(5) DEFAULT '0';

ALTER TABLE `spell_bonus_data`
  CHANGE COLUMN `entry` `entry` mediumint(8) unsigned NOT NULL DEFAULT '0';

ALTER TABLE `version`
  CHANGE COLUMN `core_version` `core_version` varchar(255) NOT NULL DEFAULT '' COMMENT 'Core revision dumped at startup.';

ALTER TABLE `waypoint_data`
  CHANGE COLUMN `wpguid` `wpguid` int(11) unsigned NOT NULL DEFAULT '0';


-- ALTER TABLE ADD COLUMN

ALTER TABLE `creature_questitem`
	ADD COLUMN `VerifiedBuild` smallint(5) NOT NULL DEFAULT '0';

ALTER TABLE `gameobject_questitem`
	ADD COLUMN `VerifiedBuild` smallint(5) NOT NULL DEFAULT '0';

ALTER TABLE `lfg_dungeon_template`
	ADD COLUMN `VerifiedBuild` smallint(5) DEFAULT '0';

ALTER TABLE `npc_vendor`
	ADD COLUMN `VerifiedBuild` smallint(5) DEFAULT '0';

ALTER TABLE `quest_poi`
	ADD COLUMN `VerifiedBuild` smallint(5) DEFAULT '0';

ALTER TABLE `spell_target_position`
	ADD COLUMN `VerifiedBuild` smallint(5) DEFAULT '0';

ALTER TABLE `quest_poi_points`
	ADD COLUMN `VerifiedBuild` smallint(5) DEFAULT '0';

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
