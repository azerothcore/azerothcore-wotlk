INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1598879518158481300');
/*
 * General: Build Update
 * Update by Knindza | <www.azerothcore.org>
 * Copyright (C) <www.shadowburn.net> & <www.lichbane.com>
*/

/* Content 3.2.2 */ 
SET @Build := 10505;

UPDATE `creature_template` SET `VerifiedBuild` = @Build WHERE `entry` IN (34383, 34382, 34653, 34710, 34744, 34675, 34708, 34644, 34654, 34676, 34711, 34478, 34481, 34479, 34677, 34678, 34679, 34712, 34713, 34714, 34768, 34476, 35254, 34482, 34435, 35261, 34480, 34484, 35260, 35256, 34477, 34483, 36479, 36506);
