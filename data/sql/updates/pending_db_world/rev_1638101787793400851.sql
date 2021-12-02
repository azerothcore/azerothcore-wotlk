INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1638101787793400851');

-- Remove underlevel RLT 24075 from Blackhand Veteran
DELETE FROM `creature_loot_template` WHERE `Entry` = 9819 AND `Reference` = 24075;

