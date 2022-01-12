INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1641915269772728685');

-- hydroflask CTM
DELETE FROM `creature_template_movement` WHERE `CreatureId` IN (13280);
INSERT INTO `creature_template_movement` (`CreatureId`, `Ground`, `Swim`, `Flight`, `Rooted`, `Chase`, `Random`, `InteractionPauseTimer`) VALUES 
(13280, 1, 1, 0, 0, 0, 0, NULL);
