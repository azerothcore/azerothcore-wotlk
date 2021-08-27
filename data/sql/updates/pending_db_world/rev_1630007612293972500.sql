INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1630007612293972500');

UPDATE `creature_addon` SET `path_id`=0 WHERE `guid` IN (3477,3560,3571);
UPDATE `creature` SET `MovementType`=0 WHERE `guid` IN (3477,3560,3571);
