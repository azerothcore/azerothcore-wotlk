INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1598881048917782600');
/*
 * General: Build Update
 * Update by Knindza | <www.azerothcore.org>
 * Copyright (C) <www.shadowburn.net> & <www.lichbane.com>
*/

/* Content 3.3.0 */ 
SET @Build := 11159;

UPDATE `quest_template` SET `VerifiedBuild` = @Build WHERE `Id` IN (24649, 24648, 24647, 24645, 24638, 24877, 24870, 24561, 24480, 24710, 24650, 24651, 25418, 25055, 24665, 24664, 24663, 24662, 24660, 24659, 24658, 24652, 24500, 24499, 24876, 24587, 24581, 24580, 24590, 24584, 24583, 24582, 24579, 13997, 24874, 24666, 24498, 24511, 24507, 24589, 24586, 24802, 24712, 24588, 24585, 24871);
