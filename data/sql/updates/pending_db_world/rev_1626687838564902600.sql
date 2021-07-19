INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1626687838564902600');

-- Pyrewood leatherworker
UPDATE `creature_template` SET `ArmorModifier` = 1.5 WHERE (`entry` = 3532);

-- Pyrewood Armorer
UPDATE `creature_template` SET `ArmorModifier` = 1.5 WHERE (`entry` = 3528);

-- Moonrage armorer
UPDATE `creature_template` SET `ArmorModifier` = 1.5 WHERE (`entry` = 3529);

-- Moonrage Leatherworker 
UPDATE `creature_template` SET `ArmorModifier` = 1.5 WHERE (`entry` = 3533);

