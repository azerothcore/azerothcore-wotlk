INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1573682333945401103');

DELETE FROM `gameobject` WHERE `id` IN (2061,2066);
UPDATE `gameobject_template` SET `Data2` = 0, `ScriptName` = 'go_flames' WHERE `type` = 8 AND `Data2` = 2061;
UPDATE `gameobject_template` SET `Data2` = 0, `ScriptName` = 'go_heat' WHERE `type` = 8 AND `Data2` = 2066;
