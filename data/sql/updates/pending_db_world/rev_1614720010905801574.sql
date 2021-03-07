INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1614720010905801574');

DELETE FROM `smart_scripts` WHERE `entryorguid` IN (4294,4295,4300,4302,4303) AND `source_type`=0 AND `id`=0;
DELETE FROM `smart_scripts` WHERE `entryorguid` IN (4298,4299,4540)  AND `source_type`=0 AND `id`=1;

