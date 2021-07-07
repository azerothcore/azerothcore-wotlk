INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1625660328991550692');

-- Correct Mezzir the Howler movement
UPDATE `creature` SET `MovementType` = 1, `wander_distance` = 15 WHERE `id` = 10197 AND `guid` = 42304;

