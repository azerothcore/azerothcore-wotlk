INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1629313785965120137');

-- Add movement to Marsh Inkspewer
UPDATE `creature` SET wander_distance = 5, `MovementType` = 1 WHERE (`id` = 750) AND (`guid` IN (42643, 43629, 42837, 43610));

-- Add movement to Marsh Murloc
UPDATE `creature` SET wander_distance = 5, `MovementType` = 1 WHERE (`id` = 747) AND (`guid` IN (43612, 43607));

-- Add movement to Jarquia
UPDATE `creature` SET wander_distance = 5, `MovementType` = 1 WHERE (`id` = 9916) AND (`guid` = 43774);

-- Remove movement to prevent clipping
UPDATE `creature` SET wander_distance = 0, `MovementType` = 0 WHERE (`id` = 752) AND (`guid` = 43658);
