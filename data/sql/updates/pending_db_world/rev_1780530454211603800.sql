DELETE FROM `creature_template_movement` WHERE `CreatureId` = 844;
INSERT INTO `creature_template_movement` (`CreatureId`, `Ground`, `Swim`, `Flight`, `Rooted`, `Chase`, `Random`, `InteractionPauseTimer`) VALUES
(844, NULL, NULL, NULL, NULL, NULL, NULL, 60000);
