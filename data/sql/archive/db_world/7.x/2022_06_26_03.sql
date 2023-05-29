-- DB update 2022_06_26_02 -> 2022_06_26_03

DELETE FROM `creature_template_movement` WHERE `CreatureId`=11502;
INSERT INTO `creature_template_movement` (`CreatureId`, `Ground`, `Swim`, `Flight`, `Rooted`, `Chase`, `Random`, `InteractionPauseTimer`) VALUES 
(11502, 0, 0, 0, 1, 0, 0, NULL);

