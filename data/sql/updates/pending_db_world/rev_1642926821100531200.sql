INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1642926821100531200');

-- ACDB 335.5-dev world
UPDATE `version` SET `db_version`='ACDB 335.6-dev', `cache_id`=6 LIMIT 1;
UPDATE `updates` SET `state`='ARCHIVED';