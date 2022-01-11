INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1641844288862423527');

-- Redridge Mulocs Not swimming fix
DELETE FROM `creature_template_movement` WHERE `CreatureId` IN (422, 548, 544, 578, 545, 1083);
INSERT INTO `creature_template_movement` (`CreatureId`, `Ground`, `Swim`, `Flight`, `Rooted`, `Chase`, `Random`, `InteractionPauseTimer`) VALUES 
(422, 1, 1, 0, 0, 0, 0, NULL),
(548, 1, 1, 0, 0, 0, 0, NULL),
(544, 1, 1, 0, 0, 0, 0, NULL),
(578, 1, 1, 0, 0, 0, 0, NULL),
(1083, 1, 1, 0, 0, 0, 0, NULL),
(545, 1, 1, 0, 0, 0, 0, NULL);
