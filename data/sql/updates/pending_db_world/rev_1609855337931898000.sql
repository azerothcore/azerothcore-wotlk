INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1609855337931898000');
ALTER TABLE `account_muted`
CHARSET = 'utf8',
MODIFY `mutedby` varchar(50) NOT NULL,
MODIFY `mutereason` varchar(255) NOT NULL;
