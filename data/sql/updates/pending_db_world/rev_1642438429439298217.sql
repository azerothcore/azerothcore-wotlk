INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1642438429439298217');

-- add mapID 44 as valid instance
DELETE FROM `instance_template` WHERE `map`=44;
INSERT INTO `instance_template` (`map`, `parent`, `script`, `allowMount`) VALUES (44, 0, '', 0);

-- add teleport location OldScarletMonastery
DELETE FROM `game_tele` WHERE `id`=1491;
INSERT INTO `game_tele` (`id`, `position_x`, `position_y`, `position_z`, `orientation`, `map`, `name`) VALUES (1491, 79, -1, 18.6778, 0, 44, 'OldScarletMonastery');
