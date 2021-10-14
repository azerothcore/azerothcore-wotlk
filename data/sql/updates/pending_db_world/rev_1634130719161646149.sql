INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1634130719161646149');

-- Delete Plans: Corruption from various NPCs
DELETE FROM `creature_loot_template` WHERE `Entry` IN (10398, 10399, 10400, 10406, 10407, 10408, 10409, 10412, 10413, 10463, 10464) AND `Item` = 12830;

-- Delete Plans: Corruption from RLT 24709
DELETE FROM `reference_loot_template` WHERE `Entry` = 24709 AND `Item` = 12830;

