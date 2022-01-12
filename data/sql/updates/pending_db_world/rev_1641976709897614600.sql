INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1641976709897614600');

-- Ragnaros, Son of Flame
DELETE FROM `creature_template_movement` WHERE `CreatureId` IN (11502, 12143);
INSERT INTO `creature_template_movement` (`CreatureId`, `Ground`, `Swim`, `Flight`, `Rooted`, `Chase`, `Random`, `InteractionPauseTimer`) VALUES 
(11502, 1, 1, 0, 0, 0, 0, NULL),
(12143, 1, 1, 0, 0, 0, 0, NULL);
