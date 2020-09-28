INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1598878453024493200');
/*
 * Object: Dire Maul - Gordok Tribute
 * Update by Knindza | <www.azerothcore.org>
 * Copyright (C) <www.shadowburn.net> & <www.lichbane.com>
*/

DELETE FROM `gameobject_loot_template` WHERE (`Entry` = 16577);
INSERT INTO `gameobject_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(16577, 1, 12007, 100, 0, 2, 0, 1, 1, NULL),
(16577, 2, 12007, 100, 0, 4, 0, 1, 1, NULL),
(16577, 3, 12007, 100, 0, 8, 0, 1, 1, NULL),
(16577, 4, 12007, 100, 0, 16, 0, 1, 1, NULL),
(16577, 5, 12007, 100, 0, 32, 0, 1, 1, NULL),
(16577, 8766, 0, 100, 0, 1, 0, 15, 20, NULL),
(16577, 8952, 0, 100, 0, 1, 0, 15, 20, NULL),
(16577, 13444, 0, 75, 0, 1, 1, 2, 5, NULL),
(16577, 13446, 0, 80, 0, 1, 1, 2, 5, NULL),
(16577, 18495, 0, 9.1, 0, 1, 1, 1, 1, NULL),
(16577, 18499, 0, 10.8, 0, 1, 1, 1, 1, NULL),
(16577, 18500, 0, 7.9, 0, 1, 1, 1, 1, NULL),
(16577, 18528, 0, 8.9, 0, 1, 1, 1, 1, NULL),
(16577, 18529, 0, 7.6, 0, 1, 1, 1, 1, NULL),
(16577, 18530, 0, 9.9, 0, 1, 1, 1, 1, NULL),
(16577, 18531, 0, 8.2, 0, 1, 1, 1, 1, NULL),
(16577, 18532, 0, 10.5, 0, 1, 1, 1, 1, NULL),
(16577, 18533, 0, 7.1, 0, 1, 1, 1, 1, NULL),
(16577, 18534, 0, 9.3, 0, 1, 1, 1, 1, NULL),
(16577, 18537, 0, 11.1, 0, 1, 1, 1, 1, NULL),
(16577, 18655, 0, 7.5, 0, 1, 1, 1, 1, NULL);
