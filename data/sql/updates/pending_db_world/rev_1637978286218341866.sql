INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1637978286218341866');

DELETE FROM `gameobject_template_addon` WHERE `entry` IN (186648,187021,186672,186667);
INSERT INTO `gameobject_template_addon` (`entry`, `faction`, `flags`, `mingold`, `maxgold`) VALUES
(186648,94,0,0,0),
(187021,94,0,0,0),
(186672,94,0,0,0),
(186667,94,0,0,0);
