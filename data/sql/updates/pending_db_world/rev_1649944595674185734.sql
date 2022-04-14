INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1649944595674185734');

-- corrects hostil to hostile
UPDATE `command` SET `name`='debug hostile' WHERE  `name`='debug hostil';
