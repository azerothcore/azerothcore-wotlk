INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1620330327979257800');

DELETE FROM `creature_addon` WHERE `guid`=3596;
UPDATE `creature` SET `wander_distance`=10, `MovementType`=1 WHERE `id`=1199;

