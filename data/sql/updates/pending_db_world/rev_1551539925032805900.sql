INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1551539925032805900');

DELETE FROM `trinity_string` WHERE `entry` = 1031;
INSERT INTO `trinity_string` (`entry`, `content_default`) VALUES
(1031, 'An account password can NOT be longer than 16 characters (client limit). Account NOT created.');

UPDATE `trinity_string` SET `content_default` = 'Account name can\'t be longer than 20 characters (client limit), account not created!' WHERE (`entry` = '1005');

