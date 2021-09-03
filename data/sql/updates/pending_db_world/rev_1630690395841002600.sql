INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1630690395841002600');

-- Fix merge of #7707
-- Set exclamation mark on Quest Items - Elegant Letters
UPDATE `item_template` SET `bonding` = 1 WHERE (`entry` = 17126);

