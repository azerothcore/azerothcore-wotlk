--
DELETE FROM `creature_template_movement` WHERE `creatureId` = 15589;
INSERT INTO `creature_template_movement` (`CreatureId`, `Ground`, `Swim`, `Flight`, `Rooted`, `Chase`, `Random`, `InteractionPauseTimer`) VALUES
(15589, 1, 0, 0, 1, 0, 0, 0);
