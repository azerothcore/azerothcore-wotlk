INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1622117565567403115');

-- Remove Shriveled Heart from Farmer Ray
DELETE FROM `creature_loot_template` WHERE `Entry` = 232 AND `Item` = 9243;
-- Remove Sunroc Mask from Sawtooth Crocolisk
DELETE FROM `creature_loot_template` WHERE `Entry` = 1082 AND `Item` = 24737;
-- Remove Sunroc Gloves from Sawtooth Snapper
DELETE FROM `creature_loot_template` WHERE `Entry` = 1087 AND `Item` = 24736;
