INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1613853959150972140');

-- Captured Scarlet Zealot should despawn himself

UPDATE `smart_scripts` SET `action_type`=51, `action_param1`=0 WHERE `entryorguid`=193100 AND `id`=7;
