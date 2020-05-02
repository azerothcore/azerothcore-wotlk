INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1588445740470602001');

-- Ouro Spawner
UPDATE `creature_template` SET `unit_flags` = `unit_flags`| 33685504, `ScriptName` = 'npc_ouro_spawner' WHERE (`entry` = 15957);
