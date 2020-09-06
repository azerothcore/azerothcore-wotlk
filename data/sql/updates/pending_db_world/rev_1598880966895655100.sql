INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1598880966895655100');
/*
 * General: Build Update
 * Update by Knindza | <www.azerothcore.org>
 * Copyright (C) <www.shadowburn.net> & <www.lichbane.com>
*/

/* Content 3.3.0 */ 
SET @Build := 11159;

UPDATE `gameobject_template` SET `VerifiedBuild` = @Build WHERE `entry` IN (202443, 202616, 202218);
