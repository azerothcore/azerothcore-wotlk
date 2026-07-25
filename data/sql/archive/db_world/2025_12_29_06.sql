-- DB update 2025_12_29_05 -> 2025_12_29_06
UPDATE `creature_template_addon` SET `auras` = '' WHERE `entry` = 30616;

DELETE FROM `creature_template_movement` WHERE `CreatureId` = 30616;
INSERT INTO `creature_template_movement` (`CreatureId`, `Ground`, `Swim`, `Flight`, `Rooted`, `Chase`, `Random`, `InteractionPauseTimer`) VALUES
(30616, 2, 0, 2, 0, 0, 0, NULL);
