INSERT INTO `version_db_auth` (`sql_rev`) VALUES ('1609867708436603000');
ALTER TABLE `account_muted`
CHARSET = 'utf8',
MODIFY `mutedby` varchar(50) NOT NULL,
MODIFY `mutereason` varchar(255) NOT NULL;
ALTER TABLE `logs`
CHARSET = 'utf8',
MODIFY `string` text;
