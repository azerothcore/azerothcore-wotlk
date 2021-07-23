INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1626687838564902600');

-- Pyrewood leatherworker, Pyrewood Armorer,Moonrage armorer, Moonrage Leatherworker 
UPDATE `creature_template` SET `ArmorModifier` = 1.5 WHERE `entry` IN (3532, 3528, 3529, 3533);

