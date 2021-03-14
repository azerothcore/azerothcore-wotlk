INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1615554526122337545');

-- Make Lady Moongazer move around
UPDATE `creature` SET `MovementType`=1, `wander_distance`=60 WHERE `guid`=37730;
