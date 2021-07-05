INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1624779042193682155');

-- Deletes underlevelled (lvl 18-19) RLT 24078 from lvl 28 Nightbane Dark Runner (ID 205), lvl 28 Dark Strand Voidcaller (ID 2337), lvl 31 Athrikus Narassin (ID 3660), lvl 50 Jadefire Rogue (ID 7106), lvl 54 Scarshield Spellbinder (ID 9098)
DELETE FROM `creature_loot_template` WHERE `Entry` IN (205, 2337, 3660, 7106, 9098) AND `Reference` = 24078;
