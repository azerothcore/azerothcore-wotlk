INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1639255994521340200');

ALTER TABLE `creature_addon` CHANGE `visibilityDistanceType` `visibilityDistanceType` TINYINT UNSIGNED DEFAULT 0 NOT NULL;
ALTER TABLE `creature_template_addon` CHANGE `visibilityDistanceType` `visibilityDistanceType` TINYINT UNSIGNED DEFAULT 0 NOT NULL;
