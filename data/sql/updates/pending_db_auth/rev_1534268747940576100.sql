INSERT INTO version_db_auth (`sql_rev`) VALUES ('1534268747940576100');

ALTER TABLE `account` 
ADD COLUMN `totaltime` int(10) UNSIGNED NOT NULL DEFAULT 0 AFTER `recruiter`;
