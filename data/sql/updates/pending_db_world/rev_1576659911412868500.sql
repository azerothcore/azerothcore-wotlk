INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1576659911412868500');

DELETE FROM `command` WHERE `name` IN ('bank', 'character check bank', 'character check bag', 'character check work');

INSERT INTO `command` VALUES
('character check bank', 2, 'Syntax: .character check bank \r\n\r\nShow your bank inventory.'),
('character check bag', 2, 'Syntax: .character check bag [$target_player]\r #bagSlot 1 - 4'),
('character check work', 2, 'Syntax: .character check work [$target_player]\r\nShow known professions list for selected player');
