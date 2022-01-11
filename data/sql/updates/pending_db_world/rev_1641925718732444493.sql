INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1641925718732444493');

-- Wailing Caverns CTM
DELETE FROM `creature_template_movement` WHERE `CreatureId` IN (5053, 5761, 5055, 3640, 3640, 5756, 5763);
INSERT INTO `creature_template_movement` (`CreatureId`, `Ground`, `Swim`, `Flight`, `Rooted`, `Chase`, `Random`, `InteractionPauseTimer`) VALUES 
(5053, 1, 1, 0, 0, 0, 0, NULL),
(5756, 1, 1, 0, 0, 0, 0, NULL),
(5763, 1, 1, 0, 0, 0, 0, NULL),
(5761, 1, 1, 0, 0, 0, 0, NULL),
(5055, 1, 1, 0, 0, 0, 0, NULL),
(3640, 1, 1, 0, 0, 0, 0, NULL),
(3640, 1, 1, 0, 0, 0, 0, NULL);
