-- 
DELETE FROM `creature_template_movement` WHERE (`CreatureId` = 8982);
INSERT INTO `creature_template_movement` (`CreatureId`, `Ground`, `Swim`, `Flight`, `Rooted`, `Chase`, `Random`, `InteractionPauseTimer`) VALUES
(8982, 1, 0, 0, 1, 0, 0, 0);
