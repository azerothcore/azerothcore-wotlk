INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1637516999973651100');

UPDATE `acore_string` SET `content_default` = 'Quest %s (%u) removed.', `locale_deDE` = '', `locale_zhCN` = '' WHERE `entry` = 473;
UPDATE `acore_string` SET `content_default` = 'Quest %s (%u) rewarded.', `locale_deDE` = '', `locale_zhCN` = '' WHERE `entry` = 474;
UPDATE `acore_string` SET `content_default` = 'Quest %s (%u) completed.', `locale_deDE` = '', `locale_zhCN` = '' WHERE `entry` = 475;
UPDATE `acore_string` SET `content_default` = 'Quest %s (%u) is already active.', `locale_deDE` = '', `locale_zhCN` = '' WHERE `entry` = 476;

DELETE FROM `acore_string` WHERE `entry` IN (1516, 5067, 5068, 5069);
INSERT INTO `acore_string` (`entry`, `content_default`) VALUES
(1516, 'Quest ID %u does not exist'),
(5067, 'Quest %s (%u) added.'),
(5068, 'Quest %s (%u) not found in quest log.'),
(5069, 'The quest must be active and complete before rewarding');
