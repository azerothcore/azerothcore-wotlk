INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1601269592461165174');

/* Horde */
DELETE FROM `creature_queststarter` WHERE (`quest` = 11431) AND (`id` IN (24657));
INSERT INTO `creature_queststarter` (`id`, `quest`) VALUES
(24657, 11431);

DELETE FROM `creature_questender` WHERE (`quest` = 11431) AND (`id` IN (24657));
INSERT INTO `creature_questender` (`id`, `quest`) VALUES
(24657, 11431);

/* Alliance */
DELETE FROM `creature_queststarter` WHERE (`quest` = 11117) AND (`id` IN (23486));
INSERT INTO `creature_queststarter` (`id`, `quest`) VALUES
(23486, 11117);

DELETE FROM `creature_questender` WHERE (`quest` = 11117) AND (`id` IN (23486));
INSERT INTO `creature_questender` (`id`, `quest`) VALUES
(23486, 11117);
