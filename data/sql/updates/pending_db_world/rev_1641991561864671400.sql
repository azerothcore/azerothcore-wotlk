INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1641991561864671400');

DELETE FROM `creature_template_movement` WHERE `CreatureId` in (3917);
INSERT INTO `creature_template_movement` (`CreatureId`, `Ground`, `Swim`, `Flight`, `Rooted`, `Chase`, `Random`, `InteractionPauseTimer`) VALUES 
(3917, 1, 1, 0, 0, 0, 0, 0);
