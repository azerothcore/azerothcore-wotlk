INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1625916764471568068');

-- Deletes lvl (min:10/avg:10.68/max:11) RLT 24074 from lvl 44 Blisterpaw Hyena (ID 5426), lvl 43 Fire Roc (ID 5429)
DELETE FROM `creature_loot_template` WHERE `Entry` IN (5426, 5429) AND `Reference` = 24074;
