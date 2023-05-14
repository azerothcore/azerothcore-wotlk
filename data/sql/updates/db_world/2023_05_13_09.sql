-- DB update 2023_05_13_08 -> 2023_05_13_09
-- 
DELETE FROM `creature_template_movement` WHERE (`CreatureId` = 8982);
INSERT INTO `creature_template_movement` (`CreatureId`, `Ground`, `Swim`, `Flight`, `Rooted`, `Chase`, `Random`, `InteractionPauseTimer`) VALUES
(8982, 1, 0, 0, 1, 0, 0, 0);
