-- DB update 2023_03_07_06 -> 2023_03_07_07
-- Sindragosa (NullCreature)
DELETE FROM `creature_template_movement` WHERE `CreatureId` = 37755;
INSERT INTO `creature_template_movement` (`CreatureId`, `Ground`, `Swim`, `Flight`, `Rooted`, `Chase`, `Random`, `InteractionPauseTimer`) VALUES
(37755, 0, 0, 2, 0, 0, 0, 0);

-- Column Ornament
DELETE FROM `creature_template_movement` WHERE `CreatureId` = 29754;
INSERT INTO `creature_template_movement` (`CreatureId`, `Ground`, `Swim`, `Flight`, `Rooted`, `Chase`, `Random`, `InteractionPauseTimer`) VALUES
(29754, 0, 0, 1, 0, 0, 0, 0);
