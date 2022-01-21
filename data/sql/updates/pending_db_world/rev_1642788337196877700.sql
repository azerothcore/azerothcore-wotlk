INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1642788337196877700');

-- ACDB 335.5-dev world
UPDATE `version` SET `db_version`='ACDB 335.6-dev', `cache_id`=6 LIMIT 1;
UPDATE `updates` SET `state`='ARCHIVED';
