INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1622621882267236728');

-- These murlocs aren't guarding anything so they should wander around
UPDATE `creature` SET `wander_distance` = 5, `MovementType` = 1 WHERE `guid` IN (37854, 37951, 37955, 37967, 37974) AND `id` BETWEEN 2201 AND 2208;

-- Murloc 37990 should face the bonfire he's standing next to
UPDATE `creature` SET `orientation` = 5.9828 WHERE `guid` = 37990 AND `id` BETWEEN 2201 AND 2208;
