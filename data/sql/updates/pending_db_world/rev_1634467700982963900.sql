INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1634467700982963900');

-- Remove SAI
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 1021);
-- Add C++ script instead
UPDATE `creature_template` SET `ScriptName`='npc_mottled_screecher' WHERE `entry`=1021;
