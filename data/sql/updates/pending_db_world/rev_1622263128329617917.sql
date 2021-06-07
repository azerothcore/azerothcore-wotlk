INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1622263128329617917');

-- Remove Scarlet Gauntlets from RLTs
DELETE FROM `reference_loot_template` WHERE `Entry` = 24056 AND `Item` = 10331;
DELETE FROM `reference_loot_template` WHERE `Entry` = 526790 AND `Item` = 10331;
-- Remove Scarlet Wristguard from RLT
DELETE FROM `reference_loot_template` WHERE `Entry` = 24054 AND `Item` = 10333;


