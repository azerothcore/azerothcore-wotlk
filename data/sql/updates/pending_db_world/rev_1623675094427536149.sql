INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1623675094427536149');

-- Makes Theramore Combat Dummies boring again.
UPDATE `creature_template` SET `mechanic_immune_mask` = 32, `flags_extra` = 262144, `ScriptName` = 'npc_training_dummy' WHERE (`entry` = 4952);
