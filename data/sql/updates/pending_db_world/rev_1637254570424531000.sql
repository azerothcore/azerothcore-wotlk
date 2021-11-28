INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1637254570424531000');

DELETE FROM `creature_template_locale` WHERE `entry` in (8673, 9856, 8724) AND `locale` in ('esES', 'esMX');
INSERT INTO `creature_template_locale` (`entry`, `locale`, `name`, `Title`, `VerifiedBuild`) VALUES 
(8673, 'esES', 'Subastador Thathung', '', 18019),
(8673, 'esMX', 'Subastador Thathung', '', 18019),
(9856, 'esES', 'Subastador Grimful', '', 18019),
(9856, 'esMX', 'Subastador Grimful', '', 18019),
(8724, 'esES', 'Subastador Wabang', '', 18019),
(8724, 'esMX', 'Subastador Wabang', '', 18019);
