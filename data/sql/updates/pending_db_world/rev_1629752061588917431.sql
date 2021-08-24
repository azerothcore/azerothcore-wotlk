INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1629752061588917431');

UPDATE `creature` SET `MovementType` = 1, `wander_distance` = 3  WHERE (`guid` IN (50173, 50175, 50176, 50177, 50179, 50180, 50194, 50195, 50196, 50198, 50203, 50205, 50206, 50215, 50216, 50217, 50218, 50222, 50227, 50230, 50235, 50244, 50250, 50251, 50252, 50253, 50254, 50291, 50297, 50307, 50313, 50314, 50317, 50319));
UPDATE `creature` SET `MovementType` = 1, `wander_distance` = 15 WHERE (`guid` IN (50800, 50268, 50269, 50270, 50294));
UPDATE `creature` SET `MovementType` = 1, `wander_distance` = 6  WHERE (`guid` IN (50314, 91739, 91738));

UPDATE `creature` SET `MovementType` = 1, `wander_distance` = 2  WHERE (`guid` IN (91746,91747,91722, 91744, 91731, 91740, 91741, 91742, 91748, 91745 ));

UPDATE `creature` SET `MovementType` = 1, `wander_distance` = 3  WHERE (`guid` IN (91720,91721));


UPDATE `creature` SET `MovementType` = 1, `wander_distance` = 4  WHERE (`guid` IN (91719 ,91721, 91728 ));

UPDATE `creature_template` SET `MovementType` = 1 WHERE (`entry` IN (5229,5231,5232,5234,5236,5237,5238,5239,5240,5241,22143,22144,22148,23022));




