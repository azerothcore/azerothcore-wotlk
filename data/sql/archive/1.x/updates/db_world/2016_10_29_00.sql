-- DB update 2016_10_23_00 -> 2016_10_29_00
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2016_10_23_00 2016_10_29_00 bit;
--
-- START UPDATING QUERIES
--
INSERT INTO version_db_world(`sql_rev`) VALUES ('1477683243N');

DELETE FROM `command` WHERE `name` = 'reload battleground_template';
INSERT INTO `command` (`name`, `security`, `help`) VALUES
('reload battleground_template', 3, 'Syntax: .reload battleground_template\r\nReload Battleground Templates.');
--
-- END UPDATING QUERIES
--
COMMIT;
