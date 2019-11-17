INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1573992675866478300');

DELETE FROM `creature_queststarter` WHERE `id` = 13278 AND `quest` = 6804;
DELETE FROM `creature_questender` WHERE `id` = 13278 AND `quest` = 6804;
INSERT INTO `creature_queststarter` (`id`, `quest`) VALUES (13278, 6804);
INSERT INTO `creature_questender` (`id`, `quest`) VALUES (13278, 6804);
