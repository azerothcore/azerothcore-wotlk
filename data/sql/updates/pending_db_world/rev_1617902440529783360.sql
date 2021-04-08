INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1617902440529783360');

# Remove Flesh Piercer from Reference Table
DELETE FROM `reference_loot_template` WHERE `Entry` = 24068 AND `Item` = 3336;

# Adds Flesh Piercer to Daggerspine Shorestalkers and Screamers loot tables
INSERT INTO `creature_loot_template` VALUES
(2368, 3336, 0, 1.5, 0, 1, 0, 1, 1, "Daggerspine Shorestalker - Flesh Piercer"),
(2370, 3336, 0, 1.1, 0, 1, 0, 1, 1, "Daggerspine Screamer - Flesh Piercer");
