INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1625629454877092500');

DELETE FROM `acore_string` WHERE `entry` = 5062;
INSERT INTO `acore_string` (`entry`, `content_default`) VALUES
(5062, 'SpellSchoolImmuneMask: %u');
