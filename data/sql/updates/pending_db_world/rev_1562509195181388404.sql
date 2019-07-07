INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1562509195181388404');

-- Disable the Saronite Bomb Spell for Eye of Eternity and Trial of the Crusader Maps https://www.wowhead.com/item=41119/saronite-bomb
DELETE FROM `disables` WHERE `sourceType` = 0 AND `entry` = 61766;
INSERT INTO `disables` (`sourceType`, `entry`, `flags`, `params_0`, `params_1`, `comment`) VALUES
(0, 61766, 17, '616,649', '', 'Disable Spell Saronite Bomb for Eye of Eternity & Trial of the Crusader');
