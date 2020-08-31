INSERT INTO `version_db_auth` (`sql_rev`) VALUES ('1598881657136430300');
/*
 * General: Auth Update
 * Update by Knindza | <www.azerothcore.org>
 * Copyright (C) <www.shadowburn.net> & <www.lichbane.com>
*/

/* Content 3.3.5  */

ALTER TABLE `account`
	CHANGE COLUMN `active` `active` TINYINT(1) UNSIGNED NOT NULL DEFAULT '0' AFTER `recruiter`,
	ADD COLUMN `frozen` TINYINT(1) UNSIGNED NOT NULL DEFAULT '0' AFTER `active`;
	
