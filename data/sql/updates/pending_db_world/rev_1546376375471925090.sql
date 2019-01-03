INSERT INTO version_db_world (`sql_rev`) VALUES ('1546376375471925090');

ALTER TABLE `creature` ADD `zoneId` SMALLINT(5) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'Zone Identifier' AFTER `map`;
ALTER TABLE `creature` ADD `areaId` SMALLINT(5) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'Area Identifier' AFTER `zoneId`;
ALTER TABLE `creature` ADD `ScriptName` CHAR(64) NULL DEFAULT '' AFTER `dynamicflags`;
ALTER TABLE `creature` ADD `VerifiedBuild` SMALLINT(5) NULL DEFAULT '0' AFTER `ScriptName`;

ALTER TABLE `gameobject` ADD `zoneId` SMALLINT(5) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'Zone Identifier' AFTER `map`;
ALTER TABLE `gameobject` ADD `areaId` SMALLINT(5) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'Area Identifier' AFTER `zoneId`; 
ALTER TABLE `gameobject` ADD `ScriptName` char(64) DEFAULT '' AFTER `state`; 
