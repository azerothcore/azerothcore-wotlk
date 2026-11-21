-- DB update 2026_11_21_05 -> 2026_11_21_06
--
-- Herbalism and Mining rank level requirements match Skinning: Apprentice 1, Journeyman 1, Expert 10,
-- Artisan 25, Master 40, Grand Master 55 (patch 3.1.0 gathering skill notes)
UPDATE `trainer_spell` SET `ReqLevel` = 0 WHERE `SpellId` IN (2372, 2373, 2581, 2582);
UPDATE `trainer_spell` SET `ReqLevel` = 40 WHERE `SpellId` IN (28696, 29355);
UPDATE `trainer_spell` SET `ReqLevel` = 55 WHERE `SpellId` = 50309;
