INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1569250786242020759');

ALTER TABLE `creature_addon` ADD COLUMN `isLarge` TINYINT(3) UNSIGNED NOT NULL DEFAULT 0 AFTER `emote`;
ALTER TABLE `creature_template_addon` ADD COLUMN `isLarge` TINYINT(3) UNSIGNED NOT NULL DEFAULT 0 AFTER `emote`;

-- Doomwalker: Enable waypoint movement and set large
UPDATE `creature_addon` SET `isLarge` = 1 WHERE `guid` = 84633;
UPDATE `creature` SET `MovementType` = 2 WHERE `guid` = 84633;

-- Fel Reaver Sentry: Set large
UPDATE `creature_addon` SET `isLarge` = 1 WHERE `guid` IN (69268,69269,69270);

-- Dun Niffelem Spear Chain Bunny (Phase 2): Set large
UPDATE `creature_addon` SET `isLarge` = 1 WHERE `guid` IN (142407,142408,142409,142410);
