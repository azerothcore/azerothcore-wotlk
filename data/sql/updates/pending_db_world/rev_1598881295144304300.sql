INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1598881295144304300');
/*
 * General: Build Update
 * Update by Knindza | <www.azerothcore.org>
 * Copyright (C) <www.shadowburn.net> & <www.lichbane.com>
*/

/* Content 3.3.5 */ 
SET @Build := 12340;

UPDATE `quest_template` SET `VerifiedBuild` = @Build WHERE `Id` IN (25470, 25461, 25446, 25444, 25348, 25229, 25092, 26034, 25480);
