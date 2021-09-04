INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1630714167178408255');

DELETE FROM `command` WHERE `name` IN ('repairitems', 'gear repair', 'gear stats');

INSERT INTO `command` VALUES
('gear repair', 2, 'Syntax: .gear repair \nRepair all selected player''s items.'),
('gear stats', 0, 'Syntax: .gear stats');
