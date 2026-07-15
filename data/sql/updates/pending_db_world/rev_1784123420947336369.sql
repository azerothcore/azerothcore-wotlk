-- Yogg Portal 'Descend Into Madness'
-- Movement flags: DisableGravity + Root
DELETE FROM `creature_template_movement` WHERE (`CreatureId` = 34072);
INSERT INTO `creature_template_movement` (`CreatureId`, `Ground`, `Swim`, `Flight`, `Rooted`, `Chase`, `Random`, `InteractionPauseTimer`) VALUES
(34072, 0, 0, 1, 1, 0, 0, 0);
