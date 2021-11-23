INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1637692848290406800');

DROP TABLE IF EXISTS `creature_movement_override`;
CREATE TABLE `creature_movement_override` (
	`SpawnId` INT UNSIGNED NOT NULL DEFAULT '0',
	`Ground` TINYINT UNSIGNED NULL DEFAULT NULL,
	`Swim` TINYINT UNSIGNED NULL DEFAULT NULL,
	`Flight` TINYINT UNSIGNED NULL DEFAULT NULL,
	`Rooted` TINYINT UNSIGNED NULL DEFAULT NULL,
	`Chase` TINYINT UNSIGNED NULL DEFAULT NULL,
	`Random` TINYINT UNSIGNED NULL DEFAULT NULL,
	`InteractionPauseTimer` INT UNSIGNED NULL DEFAULT NULL COMMENT 'Time (in milliseconds) during which creature will not move after interaction with player',
	PRIMARY KEY (`SpawnId`) USING BTREE
)
COLLATE='utf8mb4_general_ci' ENGINE=MyISAM;

DROP TABLE IF EXISTS `creature_template_movement`;
CREATE TABLE `creature_template_movement` (
	`CreatureId` INT UNSIGNED NOT NULL DEFAULT '0',
	`Ground` TINYINT UNSIGNED NULL DEFAULT NULL,
	`Swim` TINYINT UNSIGNED NULL DEFAULT NULL,
	`Flight` TINYINT UNSIGNED NULL DEFAULT NULL,
	`Rooted` TINYINT UNSIGNED NULL DEFAULT NULL,
	`Chase` TINYINT UNSIGNED NULL DEFAULT NULL,
	`Random` TINYINT UNSIGNED NULL DEFAULT NULL,
	`InteractionPauseTimer` INT UNSIGNED NULL DEFAULT NULL COMMENT 'Time (in milliseconds) during which creature will not move after interaction with player',
	PRIMARY KEY (`CreatureId`) USING BTREE
)
COLLATE='utf8mb4_general_ci' ENGINE=MyISAM;

INSERT INTO `creature_template_movement` SELECT `entry`,0,0,0,0 FROM `creature_template` WHERE `InhabitType`!=3;
UPDATE `creature_template_movement` SET `Ground`=1 WHERE `CreatureId` IN (SELECT `entry` FROM `creature_template` WHERE `InhabitType` & 1);
UPDATE `creature_template_movement` SET `Swim`=1 WHERE `CreatureId` IN (SELECT `entry` FROM `creature_template` WHERE `InhabitType` & 2);
UPDATE `creature_template_movement` SET `Flight`=1 WHERE `CreatureId` IN (SELECT `entry` FROM `creature_template` WHERE (`InhabitType` & 5) = 4);
UPDATE `creature_template_movement` SET `Flight`=2 WHERE `CreatureId` IN (SELECT `entry` FROM `creature_template` WHERE (`InhabitType` & 5) = 5);
UPDATE `creature_template_movement` SET `Rooted`=1 WHERE `CreatureId` IN (SELECT `entry` FROM `creature_template` WHERE `InhabitType` & 8);

ALTER TABLE `creature_template` DROP `InhabitType`;

DELETE FROM `creature_template_movement` WHERE `CreatureID` IN (20064,28654);
INSERT INTO `creature_template_movement` (`CreatureID`,`Ground`,`Swim`,`Flight`,`Rooted`,`Chase`,`Random`,`InteractionPauseTimer`) VALUES
(20064,1,0,0,0,2,0,0),
(28654,1,0,0,0,2,0,0);

UPDATE `acore_string` SET `content_default`='Movement type: %s' WHERE `entry`=11008;

DELETE FROM `command` WHERE `name`='reload creature_movement_override';
INSERT INTO `command` (`name`,`security`,`help`) VALUES
('reload creature_movement_override',3,'Syntax: .reload creature_movement_override\nReload creature_movement_override table.');
