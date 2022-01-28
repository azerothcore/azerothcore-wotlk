INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1642703572062384100');

DELETE FROM `spell_group` WHERE `spell_id` IN (22730, 18191, 18192, 18193, 18194, 18222, 15852);
INSERT INTO `spell_group` (`id`, `spell_id`, `special_flag`) VALUES
(1001, 22730, 0), -- Runn Tum Tuber Surprise
(1001, 18191, 0), -- Ravager Egg Omelet, Cooked Glossy Mightfish, Mightfish Steak
(1001, 18192, 0), -- Grilled Squid
(1001, 18193, 0), -- Hot Smoked Bass
(1001, 18194, 0), -- Nightfin Soup
(1001, 18222, 0), -- Poached Sunscale Salmon
(1001, 15852, 0); -- Dragonbreath Chili
