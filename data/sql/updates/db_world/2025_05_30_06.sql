-- DB update 2025_05_30_05 -> 2025_05_30_06
-- Azure Ring Captain (28236)
DELETE FROM `creature_template_movement` WHERE (`CreatureId` = 28236);
INSERT INTO `creature_template_movement` (`CreatureId`, `Ground`, `Swim`, `Flight`, `Rooted`, `Chase`, `Random`, `InteractionPauseTimer`) VALUES
(28236, 0, 0, 1, 0, 0, 0, 0);
