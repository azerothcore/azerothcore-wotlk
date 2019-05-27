INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1558943884011471260');

-- Despawn "Gearmaster Mechazod" after 300 seconds (was 3000 seconds before)
UPDATE `event_scripts` SET `datalong2` = 300000 WHERE `id` = 17209 AND `command` = 10;

-- Ensure that "The Gearmaster's Manual" is consumable (both Horde and Alliance version)
UPDATE `gameobject_template` SET `Data5` = 1 WHERE `entry` IN (190334,190335);
