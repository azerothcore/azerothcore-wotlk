INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1620616751102617000');

-- Remove path
UPDATE `creature_addon` SET `path_id`=0 WHERE `guid`=11198;

-- Make npc walk around
UPDATE `creature` SET `MovementType`=1 WHERE `guid`=11198;

