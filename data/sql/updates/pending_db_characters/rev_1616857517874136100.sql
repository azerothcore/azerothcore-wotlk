INSERT INTO `version_db_characters` (`sql_rev`) VALUES ('1616857517874136100');

DELETE FROM `warden_action` WHERE `wardenId`=437;
INSERT INTO `warden_action` (`wardenId`, `action`) VALUES
(437, 0);
