INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1598879392104489100');
/*
 * General: Build Update
 * Update by Knindza | <www.azerothcore.org>
 * Copyright (C) <www.shadowburn.net> & <www.lichbane.com>
*/

/* Content 3.2.0 */ 
SET @Build := 10314;

UPDATE `quest_template` SET `VerifiedBuild` = @Build WHERE `Id` IN (14112, 14108, 14107, 14105, 14104, 14102, 14101, 14136, 14140, 14141, 14142, 14143, 14144, 14145, 14152, 14096, 14092, 13889, 13903, 13904, 13905, 13914, 13915, 13916, 13917, 13926, 14090, 14080, 14077, 14076, 14074, 13927);
