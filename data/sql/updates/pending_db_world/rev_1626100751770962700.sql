INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1626100751770962700');

-- Add wandering to the NPCs 373, 612, 756, 921 and 1062
UPDATE `creature` SET `MovementType` = 1, `wander_distance` = 2 WHERE `id` = 1551 AND `guid` = 373;
UPDATE `creature` SET `MovementType` = 1, `wander_distance` = 2 WHERE `id` = 1551 AND `guid` = 612;
UPDATE `creature` SET `MovementType` = 1, `wander_distance` = 5 WHERE `id` = 1551 AND `guid` = 756;
UPDATE `creature` SET `MovementType` = 1, `wander_distance` = 5 WHERE `id` = 1551 AND `guid` = 981;
UPDATE `creature` SET `MovementType` = 1, `wander_distance` = 5 WHERE `id` = 1551 AND `guid` = 1062;

