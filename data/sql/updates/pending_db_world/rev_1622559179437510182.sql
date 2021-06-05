INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1622559179437510182');

SET @KURDROS := 16025;
SET @GRANISTAD := 16027;
UPDATE `creature` SET `wander_distance` = 5, `MovementType` = 1 WHERE `guid` IN (@KURDROS, @GRANISTAD);
