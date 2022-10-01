--
DELETE FROM `creature_template_movement` WHERE `creatureId` = 21221;
INSERT INTO `creature_template_movement` (`CreatureId`, `Ground`, `Swim`, `Flight`, `Rooted`, `Chase`, `Random`, `InteractionPauseTimer`) VALUES
(21221, 1, 0, 0, 1, 0, 0, 0);
