INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1638885155008688879');

-- Moves Shadowforge Surveyor up slightly so it's not stuck in object'
UPDATE `creature` SET `position_z` = 262 WHERE `id` = 4844 AND `guid` = 7714;
