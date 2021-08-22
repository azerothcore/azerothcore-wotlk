INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1629555309650648100');

# Add movement to static Vengeful Apparition
UPDATE `creature` SET `MovementType` = 1, `wander_distance` = 5 WHERE `id` = 16328 AND `guid` IN (81883, 81902, 82022, 82028, 82031, 82039);

# Add movement to static Ravening Apparition
UPDATE `creature` SET `MovementType` = 1, `wander_distance` = 5 WHERE `id` = 16327 AND `guid` IN (81872, 81873, 81874, 81880, 81884, 81889, 81903, 81904, 82024, 82034, 82037);
