-- DB update 2026_10_31_00 -> 2026_10_31_01
-- Beasts Combat Stalker: passive combat holder for the Northrend Beasts encounter
UPDATE `creature_template` SET `minlevel` = 80, `maxlevel` = 80, `AIName` = 'NullCreatureAI', `VerifiedBuild` = 50664 WHERE `entry` = 36549;

DELETE FROM `creature_template_movement` WHERE `CreatureId` = 36549;
INSERT INTO `creature_template_movement` (`CreatureId`, `Ground`, `Swim`, `Flight`, `Rooted`, `Chase`, `Random`, `InteractionPauseTimer`) VALUES
(36549, 0, 0, 1, 1, 0, 0, 0);
