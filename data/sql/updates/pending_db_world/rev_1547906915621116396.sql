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
