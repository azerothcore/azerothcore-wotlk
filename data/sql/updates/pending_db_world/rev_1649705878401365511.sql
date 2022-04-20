INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1649705878401365511');

DELETE FROM `creature_template_locale` WHERE `entry` IN (30652,30653) AND `locale` IN ('esES','esMX');
INSERT INTO `creature_template_locale` (`entry`, `locale`, `Name`, `Title`, `VerifiedBuild`) VALUES
(30652, 'esES', 'Tótem de cólera II', '', 18019),
(30652, 'esMX', 'Tótem de cólera II', '', 18019),
(30653, 'esES', 'Tótem de cólera III', '', 18019),
(30653, 'esMX', 'Tótem de cólera III', '', 18019);

