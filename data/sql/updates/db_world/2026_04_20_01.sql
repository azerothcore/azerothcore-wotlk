-- DB update 2026_04_20_00 -> 2026_04_20_01
-- Set Disable Gravity from Power Spark to Power Spark (1)
DELETE FROM `creature_template_movement` WHERE (`CreatureId` = 32187);
INSERT INTO `creature_template_movement` (`CreatureId`, `Ground`, `Swim`, `Flight`, `Rooted`, `Chase`, `Random`, `InteractionPauseTimer`) VALUES
(32187, 0, 0, 1, 0, 0, 0, 0);
