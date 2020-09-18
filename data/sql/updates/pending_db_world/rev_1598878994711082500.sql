INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1598878994711082500');
/*
 * General: Build Update
 * Update by Knindza | <www.azerothcore.org>
 * Copyright (C) <www.shadowburn.net> & <www.lichbane.com>
*/

/* Content 3.1.x */ 
SET @Build := 9767;

UPDATE `gameobject_template` SET `VerifiedBuild` = @Build WHERE `entry` IN (194200, 194213, 194238, 194307, 194312, 194316, 194324, 194340, 194341, 194356, 194423, 194424, 194463, 194479, 194519, 194537, 194538, 194539, 194541, 194542, 194543, 194555, 194565, 194569, 194625, 194628, 194752, 194789, 194902, 195036, 195046);
