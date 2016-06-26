
DELETE FROM disables WHERE sourceType=2 AND entry=615;
-- ---------------------------------
-- TEMPLATES
-- ---------------------------------
-- Drakes and helpers
REPLACE INTO creature_template VALUES (30452, 31534, 0, 0, 0, 0, 27082, 0, 0, 0, 'Tenebron', '', '', 0, 83, 83, 2, 103, 0, 1, 1, 1, 3, 509, 683, 0, 805, 27, 2000, 0, 1, 32832, 2048, 0, 0, 0, 0, 0, 0, 371, 535, 135, 2, 108, 0, 0, 70210, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 220000, 240000, '', 0, 3, 1, 70, 1, 1, 0, 0, 0, 0, 0, 0, 0, 150, 1, 617299839, 1+0x200000, 'boss_sartharion_tenebron', 1);
REPLACE INTO creature_template VALUES (31534, 0, 0, 0, 0, 0, 27082, 0, 0, 0, 'Tenebron (1)', '', '', 0, 83, 83, 2, 103, 0, 1, 1, 1, 3, 509, 683, 0, 805, 45, 2000, 0, 1, 32832, 2048, 0, 0, 0, 0, 0, 0, 371, 535, 135, 2, 108, 0, 0, 70210, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 220000, 240000, '', 0, 3, 1, 160, 1, 1, 0, 0, 0, 0, 0, 0, 0, 150, 1, 617299839, 1+0x200000, '', 1);
REPLACE INTO creature_template VALUES (30882, 31539, 0, 0, 0, 0, 28014, 0, 0, 0, 'Twilight Egg', '', '', 0, 80, 80, 2, 103, 0, 1, 1, 1, 1, 0, 0, 0, 0, 1, 2000, 0, 1, 0, 2048, 0, 0, 0, 0, 0, 0, 0, 0, 0, 10, 1088, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 1, 2, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 'npc_twilight_summon', 1);
REPLACE INTO creature_template VALUES (31539, 0, 0, 0, 0, 0, 28014, 0, 0, 0, 'Twilight Egg (1)', '', '', 0, 80, 80, 2, 103, 0, 1, 1, 1, 1, 0, 0, 0, 0, 1, 2000, 0, 1, 0, 2048, 0, 0, 0, 0, 0, 0, 0, 0, 0, 10, 1088, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 1, 6.5, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, '', 1);
REPLACE INTO creature_template VALUES (30890, 31540, 0, 0, 0, 0, 19295, 0, 0, 0, 'Twilight Whelp', '', '', 0, 81, 81, 2, 103, 0, 1, 1, 1, 1, 247, 428, 0, 312, 2, 2000, 0, 1, 0, 2048, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 72, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 1, 5, 1, 1, 0, 0, 0, 0, 0, 0, 0, 150, 1, 0, 0, 'npc_twilight_summon', 1);
REPLACE INTO creature_template VALUES (31540, 0, 0, 0, 0, 0, 19295, 0, 0, 0, 'Twilight Whelp (1)', '', '', 0, 81, 81, 2, 103, 0, 1, 1, 1, 1, 247, 428, 0, 312, 4, 2000, 0, 1, 0, 2048, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 72, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 1, 12, 1, 1, 0, 0, 0, 0, 0, 0, 0, 150, 1, 0, 0, '', 1);
REPLACE INTO creature_template VALUES (30641, 31521, 0, 0, 0, 0, 15294, 0, 0, 0, 'Twilight Fissure', '', '', 0, 1, 1, 0, 14, 0, 1, 1, 1, 0, 0, 0, 0, 0, 1, 5200, 0, 1, 0, 2048, 0, 0, 0, 0, 0, 0, 0, 0, 0, 10, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 57581, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'SmartAI', 0, 3, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 100, 1, 0, 128, '', 1);
REPLACE INTO creature_template VALUES (31521, 0, 0, 0, 0, 0, 15294, 0, 0, 0, 'Twilight Fissure (1)', '', '', 0, 1, 1, 0, 14, 0, 1, 1, 1, 0, 0, 0, 0, 0, 1, 5200, 0, 1, 0, 2048, 0, 0, 0, 0, 0, 0, 0, 0, 0, 10, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 59128, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 100, 1, 0, 128, '', 1);
REPLACE INTO creature_template VALUES (30451, 31520, 0, 0, 0, 0, 27421, 0, 0, 0, 'Shadron', '', '', 0, 83, 83, 2, 103, 0, 1, 1, 1, 3, 509, 683, 0, 805, 27, 2000, 0, 1, 32832, 2048, 0, 0, 0, 0, 0, 0, 371, 535, 135, 2, 108, 0, 0, 70210, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 220000, 240000, '', 0, 3, 1, 70, 1, 1, 0, 0, 0, 0, 0, 0, 0, 150, 1, 650854271, 1+0x200000, 'boss_sartharion_shadron', 1);
REPLACE INTO creature_template VALUES (31520, 0, 0, 0, 0, 0, 27421, 0, 0, 0, 'Shadron (1)', '', '', 0, 83, 83, 2, 103, 0, 1, 1, 1, 3, 509, 683, 0, 805, 45, 2000, 0, 1, 32832, 2048, 0, 0, 0, 0, 0, 0, 371, 535, 135, 2, 108, 0, 0, 70210, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 220000, 240000, '', 0, 3, 1, 160, 1, 1, 0, 0, 0, 0, 0, 0, 0, 150, 1, 650854271, 1+0x200000, '', 1);
REPLACE INTO creature_template VALUES (30449, 31535, 0, 0, 0, 0, 27039, 0, 0, 0, 'Vesperon', '', '', 0, 83, 83, 2, 103, 0, 1, 1, 1, 3, 509, 683, 0, 805, 27, 2000, 0, 1, 32832, 2048, 0, 0, 0, 0, 0, 0, 371, 535, 135, 2, 108, 0, 0, 70210, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 220000, 240000, '', 0, 3, 1, 70, 1, 1, 0, 0, 0, 0, 0, 0, 0, 150, 1, 650854271, 1+0x200000, 'boss_sartharion_vesperon', 1);
REPLACE INTO creature_template VALUES (31535, 0, 0, 0, 0, 0, 27039, 0, 0, 0, 'Vesperon (1)', '', '', 0, 83, 83, 2, 103, 0, 1, 1, 1, 3, 509, 683, 0, 805, 45, 2000, 0, 1, 32832, 2048, 0, 0, 0, 0, 0, 0, 371, 535, 135, 2, 108, 0, 0, 70210, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 220000, 240000, '', 0, 3, 1, 160, 1, 1, 0, 0, 0, 0, 0, 0, 0, 150, 1, 650854271, 1+0x200000, '', 1);
REPLACE INTO creature_template VALUES (30688, 31544, 0, 0, 0, 0, 8311, 0, 0, 0, 'Disciple of Shadron', '', '', 0, 81, 81, 2, 103, 0, 1.6, 1.42857, 1, 1, 425, 602, 0, 670, 7.5, 2000, 0, 2, 32832, 2048, 8, 0, 0, 0, 0, 0, 351, 511, 86, 2, 72, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 1, 10, 1, 1, 0, 0, 0, 0, 0, 0, 0, 150, 1, 0, 0, '', 12340);
REPLACE INTO creature_template VALUES (31544, 0, 0, 0, 0, 0, 8311, 0, 0, 0, 'Disciple of Shadron (1)', '', '', 0, 81, 81, 2, 103, 0, 1.6, 1.42857, 1, 1, 425, 602, 0, 670, 13, 2000, 0, 2, 32832, 2048, 8, 0, 0, 0, 0, 0, 351, 511, 86, 2, 72, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 1, 30, 1, 1, 0, 0, 0, 0, 0, 0, 0, 150, 1, 0, 0, '', 12340);
REPLACE INTO creature_template VALUES (30858, 31546, 0, 0, 0, 0, 12894, 0, 0, 0, 'Disciple of Vesperon', '', '', 0, 81, 81, 2, 103, 0, 1.6, 1.42857, 1, 1, 425, 602, 0, 670, 7.5, 2000, 0, 2, 32832, 2048, 8, 0, 0, 0, 0, 0, 351, 511, 86, 2, 72, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 1, 10, 1, 1, 0, 0, 0, 0, 0, 0, 0, 150, 1, 0, 0, '', 12340);
REPLACE INTO creature_template VALUES (31546, 0, 0, 0, 0, 0, 12894, 0, 0, 0, 'Disciple of Vesperon (1)', '', '', 0, 81, 81, 2, 103, 0, 1.6, 1.42857, 1, 1, 425, 602, 0, 670, 13, 2000, 0, 2, 32832, 2048, 8, 0, 0, 0, 0, 0, 351, 511, 86, 2, 72, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 1, 30, 1, 1, 0, 0, 0, 0, 0, 0, 0, 150, 1, 0, 0, '', 12340);
-- Trash
REPLACE INTO creature_template VALUES (30680, 30999, 0, 0, 0, 0, 27226, 0, 0, 0, 'Onyx Brood General', '', '', 0, 81, 81, 2, 103, 0, 1.6, 1.42857, 1, 1, 464, 604, 0, 708, 7.5, 2000, 0, 1, 32832, 2048, 8, 0, 0, 0, 0, 0, 353, 512, 112, 2, 72, 30680, 0, 70210, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'SmartAI', 0, 3, 1, 16, 1, 1, 0, 0, 0, 0, 0, 0, 0, 150, 1, 0, 0, '', 12340);
REPLACE INTO creature_template VALUES (30999, 0, 0, 0, 0, 0, 27226, 0, 0, 0, 'Onyx Brood General (1)', '', '', 0, 81, 81, 2, 103, 0, 1.6, 1.42857, 1, 1, 464, 604, 0, 708, 13, 2000, 0, 1, 32832, 2048, 8, 0, 0, 0, 0, 0, 353, 512, 112, 2, 72, 30998, 0, 70210, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 1, 35, 1, 1, 0, 0, 0, 0, 0, 0, 0, 150, 1, 0, 0, '', 12340);
REPLACE INTO creature_template VALUES (30681, 30998, 0, 0, 0, 0, 27227, 0, 0, 0, 'Onyx Blaze Mistress', '', '', 0, 81, 81, 2, 103, 0, 1.6, 1.42857, 1, 1, 352, 499, 0, 408, 7.5, 2000, 0, 2, 32832, 2048, 8, 0, 0, 0, 0, 0, 302, 449, 57, 2, 72, 30681, 0, 70210, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'SmartAI', 0, 3, 1, 12, 12, 1, 0, 0, 0, 0, 0, 0, 0, 150, 1, 0, 0, '', 12340);
REPLACE INTO creature_template VALUES (30998, 0, 0, 0, 0, 0, 27227, 0, 0, 0, 'Onyx Blaze Mistress (1)', '', '', 0, 81, 81, 2, 103, 0, 1.6, 1.42857, 1, 1, 425, 602, 0, 670, 13, 2000, 0, 2, 32832, 2048, 8, 0, 0, 0, 0, 0, 351, 511, 86, 2, 72, 30998, 0, 70210, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 1, 30, 12, 1, 0, 0, 0, 0, 0, 0, 0, 150, 1, 0, 0, '', 12340);
REPLACE INTO creature_template VALUES (30682, 31000, 0, 0, 0, 0, 12891, 0, 0, 0, 'Onyx Flight Captain', '', '', 0, 81, 81, 2, 103, 0, 1.6, 1.42857, 1, 1, 464, 604, 0, 708, 7.5, 2000, 0, 1, 32832, 2048, 8, 0, 0, 0, 0, 0, 353, 512, 112, 2, 72, 30682, 0, 70210, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 22581, 24534, 'SmartAI', 0, 3, 1, 12, 1, 1, 0, 0, 0, 0, 0, 0, 0, 150, 1, 0, 0, '', 12340);
REPLACE INTO creature_template VALUES (31000, 0, 0, 0, 0, 0, 12891, 0, 0, 0, 'Onyx Flight Captain (1)', '', '', 0, 81, 81, 2, 103, 0, 1.6, 1.42857, 1, 1, 464, 604, 0, 708, 13, 2000, 0, 1, 32832, 2048, 8, 0, 0, 0, 0, 0, 353, 512, 112, 2, 72, 30998, 0, 70210, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 22581, 24534, '', 0, 3, 1, 30, 1, 1, 0, 0, 0, 0, 0, 0, 0, 150, 1, 0, 0, '', 12340);
REPLACE INTO creature_template VALUES (30453, 31001, 0, 0, 0, 0, 27225, 0, 0, 0, 'Onyx Sanctum Guardian', '', '', 0, 81, 81, 2, 103, 0, 1.6, 1.42857, 1, 1, 371, 522, 0, 478, 7.5, 2000, 0, 1, 32832, 2048, 8, 0, 0, 0, 0, 0, 314, 466, 81, 2, 72, 30453, 0, 70210, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 21855, 23530, 'SmartAI', 0, 3, 1, 30, 1, 1, 0, 0, 0, 0, 0, 0, 0, 150, 1, 0, 0, '', 12340);
REPLACE INTO creature_template VALUES (31001, 0, 0, 0, 0, 0, 27225, 0, 0, 0, 'Onyx Sanctum Guardian (1)', '', '', 0, 81, 81, 2, 103, 0, 1.6, 1.42857, 1, 1, 464, 604, 0, 708, 13, 2000, 0, 1, 32832, 2048, 8, 0, 0, 0, 0, 0, 353, 512, 112, 2, 72, 30998, 0, 70210, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 21855, 23530, '', 0, 3, 1, 60, 1, 1, 0, 0, 0, 0, 0, 0, 0, 150, 1, 0, 0, '', 12340);
-- Sartharion 
UPDATE creature_model_info SET combat_reach=10 WHERE modelid=27035;
REPLACE INTO creature_template VALUES (28860, 31311, 0, 0, 0, 0, 27035, 0, 0, 0, 'Sartharion', 'The Onyx Guardian', '', 0, 83, 83, 2, 103, 0, 1, 1, 1, 3, 509, 683, 0, 805, 27, 2000, 0, 1, 32832, 2048, 0, 0, 0, 0, 0, 0, 371, 535, 135, 2, 108, 28860, 0, 28860, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 520000, 540000, '', 0, 3, 1, 180, 1, 1, 0, 0, 0, 0, 0, 0, 0, 150, 1, 650854271, 1+0x200000, 'boss_sartharion', 1);
REPLACE INTO creature_template VALUES (31311, 0, 0, 0, 0, 0, 27035, 0, 0, 0, 'Sartharion (1)', 'The Onyx Guardian', '', 0, 83, 83, 2, 103, 0, 1, 1, 1, 3, 509, 683, 0, 805, 45, 2000, 0, 1, 32832, 2048, 0, 0, 0, 0, 0, 0, 371, 535, 135, 2, 108, 31311, 0, 28860, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 520000, 540000, '', 0, 3, 1, 550, 1, 1, 0, 0, 0, 0, 0, 0, 0, 150, 1, 650854271, 1+0x200000, '', 1);
REPLACE INTO creature_template VALUES (30643, 31317, 0, 0, 0, 0, 2172, 0, 0, 0, 'Lava Blaze', '', '', 0, 81, 81, 2, 103, 0, 1, 1, 1, 0, 421, 636, 0, 171, 1.4, 2000, 0, 1, 0, 2048, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 1, 2, 1, 1, 0, 0, 0, 0, 0, 0, 0, 121, 1, 0, 0, '', 1);
REPLACE INTO creature_template VALUES (31317, 0, 0, 0, 0, 0, 2172, 0, 0, 0, 'Lava Blaze (1)', '', '', 0, 81, 81, 2, 103, 0, 1, 1, 1, 0, 421, 636, 0, 171, 1.4, 2000, 0, 1, 0, 2048, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 1, 5, 1, 1, 0, 0, 0, 0, 0, 0, 0, 121, 1, 0, 0, '', 1);
REPLACE INTO creature_template VALUES (30648, 0, 0, 0, 0, 0, 11686, 0, 0, 0, 'Fire Cyclone', '', '', 0, 83, 83, 0, 14, 0, 1, 1.14286, 1, 0, 509, 683, 0, 805, 1, 2000, 0, 1, 33554434, 2048, 8, 0, 0, 0, 0, 0, 371, 535, 135, 10, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'NullCreatureAI', 0, 3, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 130, '', 12340);
REPLACE INTO creature_template VALUES (30616, 0, 0, 0, 0, 0, 0, 16925, 0, 0, 'Flame Tsunami', '', '', 0, 83, 83, 2, 103, 0, 1, 1, 1, 0, 0, 0, 0, 0, 1, 2000, 0, 1, 33554434, 2048, 0, 0, 0, 0, 0, 0, 0, 0, 0, 10, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'NullCreatureAI', 0, 4, 1, 20, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 130, '', 1);
REPLACE INTO creature_template VALUES (31219, 31543, 0, 0, 0, 0, 12894, 0, 0, 0, 'Acolyte of Vesperon', '', '', 0, 81, 81, 2, 103, 0, 1, 1, 1, 1, 247, 428, 0, 312, 10, 2000, 0, 2, 0, 2048, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 72, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 1, 15, 1, 1, 0, 0, 0, 0, 0, 0, 0, 150, 1, 0, 0, '', 1);
REPLACE INTO creature_template VALUES (31543, 0, 0, 0, 0, 0, 12894, 0, 0, 0, 'Acolyte of Vesperon (1)', '', '', 0, 81, 81, 2, 103, 0, 1, 1, 1, 1, 247, 428, 0, 312, 20, 2000, 0, 2, 0, 2048, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 72, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 1, 25, 1, 1, 0, 0, 0, 0, 0, 0, 0, 150, 1, 0, 0, '', 1);
REPLACE INTO creature_template VALUES (31218, 31541, 0, 0, 0, 0, 8311, 0, 0, 0, 'Acolyte of Shadron', '', '', 0, 81, 81, 2, 103, 0, 1, 1, 1, 1, 247, 428, 0, 312, 10, 2000, 0, 2, 0, 2048, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 72, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 1, 15, 1, 1, 0, 0, 0, 0, 0, 0, 0, 150, 1, 0, 0, '', 1);
REPLACE INTO creature_template VALUES (31541, 0, 0, 0, 0, 0, 8311, 0, 0, 0, 'Acolyte of Shadron (1)', '', '', 0, 81, 81, 2, 103, 0, 1, 1, 1, 1, 247, 428, 0, 312, 20, 2000, 0, 2, 0, 2048, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 72, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 1, 25, 1, 1, 0, 0, 0, 0, 0, 0, 0, 150, 1, 0, 0, '', 1);
REPLACE INTO creature_template VALUES (30494, 0, 0, 0, 0, 0, 15435, 0, 0, 0, 'Safe Area (Sartharion)', '', '', 0, 83, 83, 2, 35, 0, 1, 0.992063, 1, 0, 509, 683, 0, 805, 1, 2000, 0, 1, 33554432, 2048, 8, 0, 0, 0, 0, 0, 371, 535, 135, 10, 1024, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, '', 12340);

DELETE FROM creature_loot_template WHERE entry IN(30452, 31534, 30451, 31520, 30449, 31535);

-- delete not needed script
UPDATE creature_template SET ScriptName='' WHERE entry=31214;

-- ---------------------------------
-- SPELL DIFFICULTY
-- ---------------------------------
-- Shadow Breath
REPLACE INTO spelldifficulty_dbc VALUES(5000, 57570, 59126, 0, 0);
-- Shadow Fissure
REPLACE INTO spelldifficulty_dbc VALUES(5001, 57579, 59127, 0, 0);
-- Void Blast (Shadow Fissure trigger)
REPLACE INTO spelldifficulty_dbc VALUES(5002, 57581, 59128, 0, 0);
-- Flame Shock
REPLACE INTO spelldifficulty_dbc VALUES(5003, 39529, 58940, 0, 0);
-- Rain of Fire
REPLACE INTO spelldifficulty_dbc VALUES(5004, 57757, 58936, 0, 0);
-- Shockwave
REPLACE INTO spelldifficulty_dbc VALUES(5005, 57728, 58947, 0, 0);
-- Flame Breath
REPLACE INTO spelldifficulty_dbc VALUES(5006, 56908, 58956, 0, 0);
-- Tail Lash
REPLACE INTO spelldifficulty_dbc VALUES(5007, 56910, 58957, 0, 0);
-- Cyclone Aura
REPLACE INTO spelldifficulty_dbc VALUES(5008, 57598, 58964, 0, 0);

-- ---------------------------------
-- SPELL_LINKED_SPELL
-- ---------------------------------
DELETE FROM spell_linked_spell WHERE spell_trigger=-57620;
INSERT INTO spell_linked_spell VALUES(-57620, -57874, 0, "Twilight Phase Shift trigger remove");
INSERT INTO spell_linked_spell VALUES(-57620, 61885, 0, "Twilight Phase Shift immunity add");
DELETE FROM spell_linked_spell WHERE spell_trigger=61187;
INSERT INTO spell_linked_spell VALUES(61187, -57620, 1, "Twilight Phase Shift normal remove");

DELETE FROM spell_script_names WHERE spell_id IN(57578, 57591, 56911);
INSERT INTO spell_script_names VALUES(57578, "spell_sartharion_lava_strike");
INSERT INTO spell_script_names VALUES(57591, "spell_sartharion_lava_strike");

-- ---------------------------------
-- SMART SCRIPTS
-- ---------------------------------
-- Shadow Fissure
DELETE FROM smart_scripts WHERE entryorguid=30641 AND source_type=0;
INSERT INTO smart_scripts VALUES(30641, 0, 0, 0, 60, 0, 100, 1, 5100, 5100, 0, 0, 11, 57581, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Cast Spell on Update");
-- Trash
DELETE FROM smart_scripts WHERE entryorguid IN(30680, 30681, 30682, 30453) AND source_type=0;
INSERT INTO smart_scripts VALUES(30680, 0, 0, 0, 0, 0, 100, 0, 5000, 6000, 7000, 8000, 11, 13737, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, "Cast Spell on IC");
INSERT INTO smart_scripts VALUES(30680, 0, 1, 0, 0, 0, 100, 0, 15000, 15000, 40000, 40000, 11, 57733, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Cast Spell on IC");
INSERT INTO smart_scripts VALUES(30681, 0, 0, 0, 0, 0, 100, 0, 5000, 6000, 7000, 8000, 11, 39529, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, "Cast Spell on IC");
INSERT INTO smart_scripts VALUES(30681, 0, 1, 0, 0, 0, 100, 0, 15000, 15000, 20000, 20000, 11, 57757, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, "Cast Spell on IC");
INSERT INTO smart_scripts VALUES(30682, 0, 0, 0, 0, 0, 100, 0, 5000, 6000, 7000, 8000, 11, 57759, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, "Cast Spell on IC");
INSERT INTO smart_scripts VALUES(30682, 0, 1, 0, 13, 0, 100, 0, 3000, 3000, 0, 0, 11, 58953, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, "Cast Spell on Target Cast");
INSERT INTO smart_scripts VALUES(30453, 0, 0, 0, 0, 0, 100, 0, 7000, 9000, 17000, 18000, 11, 57728, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, "Cast Spell on IC");
INSERT INTO smart_scripts VALUES(30453, 0, 1, 0, 0, 0, 100, 0, 13000, 13000, 30000, 30000, 11, 39647, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, "Cast Spell on IC");
INSERT INTO smart_scripts VALUES(30453, 0, 2, 0, 12, 1, 100, 0, 25, 30, 5000, 5000, 11, 53801, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "Cast Spell on Target health pct");

-- ---------------------------------
-- FORMATIONS
-- ---------------------------------
DELETE FROM creature_formations WHERE leaderGUID IN(126396, 126400, 126416, 126399, 126398, 126397, 126418, 126420);
INSERT INTO creature_formations VALUES(126400, 126400, 0, 0, 0, 0, 0);
INSERT INTO creature_formations VALUES(126400, 126406, 10, 90, 0, 0, 0);
INSERT INTO creature_formations VALUES(126400, 126412, 10, 180, 0, 0, 0);
INSERT INTO creature_formations VALUES(126400, 126405, 10, 270, 0, 0, 0);
INSERT INTO creature_formations VALUES(126399, 126399, 0, 0, 0, 0, 0);
INSERT INTO creature_formations VALUES(126399, 126403, 10, 90, 0, 0, 0);
INSERT INTO creature_formations VALUES(126399, 126411, 10, 180, 0, 0, 0);
INSERT INTO creature_formations VALUES(126399, 126404, 10, 270, 0, 0, 0);
INSERT INTO creature_formations VALUES(126398, 126398, 0, 0, 0, 0, 0);
INSERT INTO creature_formations VALUES(126398, 126409, 10, 90, 0, 0, 0);
INSERT INTO creature_formations VALUES(126398, 126402, 10, 180, 0, 0, 0);
INSERT INTO creature_formations VALUES(126398, 126410, 10, 270, 0, 0, 0);
INSERT INTO creature_formations VALUES(126397, 126397, 0, 0, 0, 0, 0);
INSERT INTO creature_formations VALUES(126397, 126408, 10, 90, 0, 0, 0);
INSERT INTO creature_formations VALUES(126397, 126401, 10, 180, 0, 0, 0);
INSERT INTO creature_formations VALUES(126397, 126407, 10, 270, 0, 0, 0);
-- ---------------------------------
-- MISC
-- ---------------------------------
-- Missing text emote
DELETE FROM creature_text WHERE entry=28860 AND groupid=7 AND id=3;
REPLACE INTO creature_text VALUES(30449, 10, 0, 'All will be reduced to ash!', 14, 0, 100, 0, 0, 14102, 0, 'sartharion SAY_SARTHARION_SPECIAL_4');
-- Disciples texts
REPLACE INTO creature_text VALUES(30449, 7, 0, 'A Vesperon Disciple appears in the Twilight!', 42, 0, 100, 0, 0, 0, 0, 'Vesperon Call Summon');
REPLACE INTO creature_text VALUES(30451, 7, 0, 'A Shadron Disciple appears in the Twilight!', 42, 0, 100, 0, 0, 0, 0, 'Shadron Call Summon');

-- Template Addons
REPLACE INTO creature_template_addon VALUES(30882, 0, 0, 0, 1, 0, "58547");
REPLACE INTO creature_template_addon VALUES(31539, 0, 0, 0, 1, 0, "58547");
DELETE FROM creature_addon WHERE guid IN(SELECT guid FROM creature WHERE id IN(30680, 30681, 30682, 30453, 30648));
REPLACE INTO creature_template_addon VALUES(30680, 0, 0, 0, 1, 0, "57742, 57740");
REPLACE INTO creature_template_addon VALUES(30999, 0, 0, 0, 1, 0, "57742, 58944");
REPLACE INTO creature_template_addon VALUES(30681, 0, 0, 0, 1, 0, "57740");
REPLACE INTO creature_template_addon VALUES(30998, 0, 0, 0, 1, 0, "58944");
REPLACE INTO creature_template_addon VALUES(30682, 0, 0, 0, 1, 0, "57740");
REPLACE INTO creature_template_addon VALUES(31000, 0, 0, 0, 1, 0, "58944");
REPLACE INTO creature_template_addon VALUES(30616, 0, 0, 0, 1, 0, "57492 57494");
REPLACE INTO creature_template_addon VALUES(30648, 0, 0, 0, 1, 0, "57560");
REPLACE INTO creature_template_addon VALUES(30494, 0, 0, 0, 1, 0, "56911");

-- Conditions
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry=61254;
INSERT INTO conditions VALUES(13, 1, 61254, 0, 0, 31, 0, 3, 30451, 0, 0, 0, 0, '', '');
INSERT INTO conditions VALUES(13, 1, 61254, 0, 1, 31, 0, 3, 30449, 0, 0, 0, 0, '', '');
INSERT INTO conditions VALUES(13, 1, 61254, 0, 2, 31, 0, 3, 30452, 0, 0, 0, 0, '', '');
INSERT INTO conditions VALUES(13, 1, 61254, 0, 0, 36, 0, 0, 0, 0, 0, 0, 0, '', '');
INSERT INTO conditions VALUES(13, 1, 61254, 0, 1, 36, 0, 0, 0, 0, 0, 0, 0, '', '');
INSERT INTO conditions VALUES(13, 1, 61254, 0, 2, 36, 0, 0, 0, 0, 0, 0, 0, '', '');
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry=60430;
INSERT INTO conditions VALUES(13, 7, 60430, 0, 0, 31, 0, 3, 30643, 0, 0, 0, 0, '', '');
INSERT INTO conditions VALUES(13, 7, 60430, 0, 0, 36, 0, 0, 0, 0, 0, 0, 0, '', '');
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry=58766;
INSERT INTO conditions VALUES(13, 3, 58766, 0, 0, 31, 0, 3, 28860, 0, 0, 0, 0, '', '');
INSERT INTO conditions VALUES(13, 3, 58766, 0, 0, 36, 0, 0, 0, 0, 0, 0, 0, '', '');
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry=57835;
INSERT INTO conditions VALUES(13, 3, 57835, 0, 0, 31, 0, 3, 30451, 0, 0, 0, 0, '', '');
INSERT INTO conditions VALUES(13, 3, 57835, 0, 0, 36, 0, 0, 0, 0, 0, 0, 0, '', '');
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry=60639;
INSERT INTO conditions VALUES(13, 3, 60639, 0, 0, 31, 0, 3, 28860, 0, 0, 0, 0, '', '');
INSERT INTO conditions VALUES(13, 3, 60639, 0, 0, 36, 0, 0, 0, 0, 0, 0, 0, '', '');
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry=61632;
INSERT INTO conditions VALUES(13, 7, 61632, 0, 0, 31, 0, 3, 30451, 0, 0, 0, 0, '', '');
INSERT INTO conditions VALUES(13, 7, 61632, 0, 1, 31, 0, 3, 30449, 0, 0, 0, 0, '', '');
INSERT INTO conditions VALUES(13, 7, 61632, 0, 2, 31, 0, 3, 30452, 0, 0, 0, 0, '', '');
INSERT INTO conditions VALUES(13, 7, 61632, 0, 0, 36, 0, 0, 0, 0, 0, 0, 0, '', '');
INSERT INTO conditions VALUES(13, 7, 61632, 0, 1, 36, 0, 0, 0, 0, 0, 0, 0, '', '');
INSERT INTO conditions VALUES(13, 7, 61632, 0, 2, 36, 0, 0, 0, 0, 0, 0, 0, '', '');
DELETE FROM conditions WHERE SourceTypeOrReferenceId=13 AND SourceEntry=57578;
INSERT INTO conditions VALUES(13, 1, 57578, 0, 0, 31, 0, 4, 0, 0, 0, 0, 0, '', '');
INSERT INTO conditions VALUES(13, 1, 57578, 0, 0, 36, 0, 0, 0, 0, 0, 0, 0, '', '');

-- ---------------------------------
-- SPAWNS
-- ---------------------------------
DELETE FROM creature_addon WHERE guid IN(SELECT guid FROM creature WHERE id IN(31138, 30648, 30494));
DELETE FROM creature WHERE id IN(31138, 30648, 30494);

DELETE FROM gameobject WHERE id=193989;
INSERT INTO gameobject VALUES (NULL, 193989, 615, 3, 16, 3351.78, 517.138, 99.162, 1.12686, 0, 0, 0.534089, 0.845428, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (NULL, 193989, 615, 3, 16, 3247.29, 529.804, 58.9595, 1.45581, 0, 0, 0.665309, 0.746568, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (NULL, 193989, 615, 3, 16, 3151.2, 517.862, 90.3389, 1.55617, 0, 0, 0.701917, 0.712259, 300, 0, 1, 0);
INSERT INTO gameobject VALUES (NULL, 193989, 615, 3, 16, 3248.62, 646.739, 85.2939, 4.60225, 0, 0, 0.744956, -0.667114, 300, 0, 1, 0);

UPDATE gameobject_template SET flags=32 WHERE entry=193988;

-- ---------------------------------
-- WAYPOINTS
-- ---------------------------------
DELETE FROM waypoint_data WHERE id IN(304520, 304510, 304490);
INSERT INTO waypoint_data VALUES (304520, 8, 3240.86, 530.693, 72.1231, 0, 0, 1, 0, 100, 0);
INSERT INTO waypoint_data VALUES (304520, 7, 3236.91, 515.697, 77.357, 0, 0, 1, 0, 100, 0);
INSERT INTO waypoint_data VALUES (304520, 6, 3246.81, 505.824, 78.3057, 0, 0, 1, 0, 100, 0);
INSERT INTO waypoint_data VALUES (304520, 5, 3258.82, 501.412, 78.6243, 0, 0, 1, 0, 100, 0);
INSERT INTO waypoint_data VALUES (304520, 4, 3271.54, 503.191, 79.3313, 0, 0, 1, 0, 100, 0);
INSERT INTO waypoint_data VALUES (304520, 3, 3283.8, 519.814, 82.2887, 0, 0, 1, 0, 100, 0);
INSERT INTO waypoint_data VALUES (304520, 2, 3277.48, 584.647, 91.5467, 0, 0, 1, 0, 100, 0);
INSERT INTO waypoint_data VALUES (304520, 1, 3250.46, 641.251, 95.5391, 0, 0, 1, 0, 100, 0);
INSERT INTO waypoint_data VALUES (304520, 9, 3249.09, 556.949, 61.9919, 0, 0, 1, 0, 100, 0);
INSERT INTO waypoint_data VALUES (304510, 1, 3342.09, 520.511, 107.259, 0, 0, 1, 0, 100, 0);
INSERT INTO waypoint_data VALUES (304510, 2, 3320.07, 522.925, 96.8165, 0, 0, 1, 0, 100, 0);
INSERT INTO waypoint_data VALUES (304510, 3, 3289.03, 526.002, 80.9268, 0, 0, 1, 0, 100, 0);
INSERT INTO waypoint_data VALUES (304510, 4, 3266.77, 528.037, 72.43, 0, 0, 1, 0, 100, 0);
INSERT INTO waypoint_data VALUES (304510, 5, 3230.07, 531.24, 62.0423, 0, 0, 1, 0, 100, 0);
INSERT INTO waypoint_data VALUES (304490, 1, 3161.77, 516.343, 102.208, 0, 0, 1, 0, 100, 0);
INSERT INTO waypoint_data VALUES (304490, 2, 3172.33, 516.114, 100.179, 0, 0, 1, 0, 100, 0);
INSERT INTO waypoint_data VALUES (304490, 3, 3206.77, 514.876, 78.8664, 0, 0, 1, 0, 100, 0);
INSERT INTO waypoint_data VALUES (304490, 4, 3229.02, 514.075, 71.2539, 0, 0, 1, 0, 100, 0);
INSERT INTO waypoint_data VALUES (304490, 5, 3262.92, 513.923, 61.1371, 0, 0, 1, 0, 100, 0);

-- ---------------------------------
-- ACHIEVEMENTS
-- ---------------------------------
-- Besting the Black Dragonflight (10 player) (1876)
DELETE FROM achievement_criteria_data WHERE criteria_id IN(7184);
DELETE FROM disables WHERE sourceType=4 AND entry IN(7184);
INSERT INTO achievement_criteria_data VALUES(7184, 0, 0, 0, "");
INSERT INTO achievement_criteria_data VALUES(7184, 12, 0, 0, "");

-- Besting the Black Dragonflight (25 player) (625)
DELETE FROM achievement_criteria_data WHERE criteria_id IN(523);
DELETE FROM disables WHERE sourceType=4 AND entry IN(523);
INSERT INTO achievement_criteria_data VALUES(523, 0, 0, 0, "");
INSERT INTO achievement_criteria_data VALUES(523, 12, 1, 0, "");

-- Gonna Go When the Volcano Blows (10 player) (2047)
DELETE FROM achievement_criteria_data WHERE criteria_id IN(7326);
DELETE FROM disables WHERE sourceType=4 AND entry IN(7326);
INSERT INTO achievement_criteria_data VALUES(7326, 18, 0, 0, "");
INSERT INTO achievement_criteria_data VALUES(7326, 12, 0, 0, "");

-- Gonna Go When the Volcano Blows (25 player) (2048)
DELETE FROM achievement_criteria_data WHERE criteria_id IN(7327);
DELETE FROM disables WHERE sourceType=4 AND entry IN(7327);
INSERT INTO achievement_criteria_data VALUES(7327, 18, 0, 0, "");
INSERT INTO achievement_criteria_data VALUES(7327, 12, 1, 0, "");

-- Less Is More (10 player) (624)
DELETE FROM achievement_criteria_data WHERE criteria_id IN(7189, 7190, 7191, 522);
DELETE FROM disables WHERE sourceType=4 AND entry IN(7189, 7190, 7191, 522);
INSERT INTO achievement_criteria_data VALUES(7189, 18, 0, 0, "");
INSERT INTO achievement_criteria_data VALUES(7190, 18, 0, 0, "");
INSERT INTO achievement_criteria_data VALUES(7191, 18, 0, 0, "");
INSERT INTO achievement_criteria_data VALUES(522, 18, 0, 0, "");
INSERT INTO achievement_criteria_data VALUES(7189, 12, 0, 0, "");
INSERT INTO achievement_criteria_data VALUES(7190, 12, 0, 0, "");
INSERT INTO achievement_criteria_data VALUES(7191, 12, 0, 0, "");
INSERT INTO achievement_criteria_data VALUES(522, 12, 0, 0, "");

-- Less Is More (25 player) (1877)
DELETE FROM achievement_criteria_data WHERE criteria_id IN(7185, 7186, 7187, 7188);
DELETE FROM disables WHERE sourceType=4 AND entry IN(7185, 7186, 7187, 7188);
INSERT INTO achievement_criteria_data VALUES(7185, 18, 0, 0, "");
INSERT INTO achievement_criteria_data VALUES(7186, 18, 0, 0, "");
INSERT INTO achievement_criteria_data VALUES(7187, 18, 0, 0, "");
INSERT INTO achievement_criteria_data VALUES(7188, 18, 0, 0, "");
INSERT INTO achievement_criteria_data VALUES(7185, 12, 1, 0, "");
INSERT INTO achievement_criteria_data VALUES(7186, 12, 1, 0, "");
INSERT INTO achievement_criteria_data VALUES(7187, 12, 1, 0, "");
INSERT INTO achievement_criteria_data VALUES(7188, 12, 1, 0, "");

-- Twilight Assist (10 player) (2049)
DELETE FROM achievement_criteria_data WHERE criteria_id IN(7328);
DELETE FROM disables WHERE sourceType=4 AND entry IN(7328);
INSERT INTO achievement_criteria_data VALUES(7328, 18, 0, 0, "");
INSERT INTO achievement_criteria_data VALUES(7328, 12, 0, 0, "");

-- Twilight Assist (25 player) (2052)
DELETE FROM achievement_criteria_data WHERE criteria_id IN(7331);
DELETE FROM disables WHERE sourceType=4 AND entry IN(7331);
INSERT INTO achievement_criteria_data VALUES(7331, 18, 0, 0, "");
INSERT INTO achievement_criteria_data VALUES(7331, 12, 1, 0, "");

-- Twilight Duo (10 player) (2050)
DELETE FROM achievement_criteria_data WHERE criteria_id IN(7329);
DELETE FROM disables WHERE sourceType=4 AND entry IN(7329);
INSERT INTO achievement_criteria_data VALUES(7329, 18, 0, 0, "");
INSERT INTO achievement_criteria_data VALUES(7329, 12, 0, 0, "");

-- Twilight Duo (25 player) (2053)
DELETE FROM achievement_criteria_data WHERE criteria_id IN(7332);
DELETE FROM disables WHERE sourceType=4 AND entry IN(7332);
INSERT INTO achievement_criteria_data VALUES(7332, 18, 0, 0, "");
INSERT INTO achievement_criteria_data VALUES(7332, 12, 1, 0, "");

-- Twilight Zone (10 player) (2051)
DELETE FROM achievement_criteria_data WHERE criteria_id IN(7330);
DELETE FROM disables WHERE sourceType=4 AND entry IN(7330);
INSERT INTO achievement_criteria_data VALUES(7330, 18, 0, 0, "");
INSERT INTO achievement_criteria_data VALUES(7330, 12, 0, 0, "");

-- Twilight Zone (25 player) (2054)
DELETE FROM achievement_criteria_data WHERE criteria_id IN(7333);
DELETE FROM disables WHERE sourceType=4 AND entry IN(7333);
INSERT INTO achievement_criteria_data VALUES(7333, 18, 0, 0, "");
INSERT INTO achievement_criteria_data VALUES(7333, 12, 1, 0, "");

-- Realm First! Obsidian Slayer (456)
DELETE FROM achievement_criteria_data WHERE criteria_id IN(5224);
DELETE FROM disables WHERE sourceType=4 AND entry IN(5224);
INSERT INTO achievement_criteria_data VALUES(5224, 12, 1, 0, "");
