INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1623568768400505753');

-- Deletes RLT 24054 from lvl 12 Gamon, ID 6466 (96 items/25 level gap)
DELETE FROM `creature_loot_template` WHERE `Entry` = 6466 AND `Reference` = 24054;

-- Deletes RLT 24042 from lvl 24 Galak Packhound, ID 4250 (12 items/21 level gap)
DELETE FROM `creature_loot_template` WHERE `Entry` = 4250 AND `Reference` = 24042;

-- Deletes RLT 24056 from lvl 21 Syndicate Rogue, ID 2260 (92 items/17 level gap)
DELETE FROM `creature_loot_template` WHERE `Entry` = 2260 AND `Reference` = 24056;

-- Deletes RLT 24025 from lvl 37 Rigglefuzz, ID 2817 (108 items/14 level gap)
DELETE FROM `creature_loot_template` WHERE `Entry` = 2817 AND `Reference` = 24025;
