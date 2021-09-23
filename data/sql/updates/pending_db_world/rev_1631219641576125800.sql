INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1631219641576125800');

UPDATE `creature_template` SET `ScriptName`='npc_shay_leafrunner', `AiName`='' WHERE `entry`=7774;
DELETE FROM `smart_scripts` WHERE `entryorguid`=7774 AND `source_type`=0;
DELETE FROM `smart_scripts` WHERE `entryorguid`=777400 AND `source_type`=9;
