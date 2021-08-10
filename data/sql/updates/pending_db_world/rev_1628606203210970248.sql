INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1628606203210970248');

-- Add motion to Dunemaul Ogres
UPDATE `creature` SET `MovementType` = 1, `wander_distance` = 10 WHERE `id` = 5471 AND `guid` IN (23126, 23127, 23131);

-- Add motion to Dunemaul Enforcers
UPDATE `creature` SET `MovementType` = 1, `wander_distance` = 5 WHERE `id` = 5472 AND `guid` IN (23136, 23137, 23138, 23144, 23145, 23151, 23153);

-- Add motion to Dunemaul Ogre Mage
UPDATE `creature` SET `MovementType` = 1, `wander_distance` = 10 WHERE `id` = 5473 AND `guid` = 23162;

-- Add motion to Dunemaul Brutes
UPDATE `creature` SET `MovementType` = 1, `wander_distance` = 5 WHERE `id` = 5474 AND `guid` IN (23173, 23177, 23178, 23180, 23181, 23182, 23183, 23184);

-- Add motion to Dunemaul Warlocks
UPDATE `creature` SET `MovementType` = 1, `wander_distance` = 10 WHERE `id` = 5475 AND `guid` IN (23197, 23209, 23213);

