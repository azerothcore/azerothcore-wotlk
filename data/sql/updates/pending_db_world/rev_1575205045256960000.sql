INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1575205045256960000');

DELETE FROM `creature_template_locale` WHERE `entry`=13476 AND `locale`='deDE';
INSERT INTO `creature_template_locale` (`entry`, `locale`, `Name`, `Title`, `VerifiedBuild`) VALUES (13476, 'deDE', 'Balai Lok\'Wein', 'Tränke, Schriftrollen & Reagenzien', 18019);
