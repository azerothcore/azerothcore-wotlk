INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1598881458930915100');
/*
 * General: Emerald Dream Update
 * Update by Knindza | <www.azerothcore.org>
 * Copyright (C) <www.shadowburn.net> & <www.lichbane.com>
*/

/* Content 3.3.5 */

DELETE FROM `instance_template` WHERE `map`=169;
INSERT INTO `instance_template` (`map`, `parent`, `script`, `allowMount`) VALUES (169, 0, '', 1);
