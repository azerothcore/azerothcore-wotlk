INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1634719155364267500');

DELETE FROM `smart_scripts` WHERE `entryorguid`=17589 AND `source_type`=0;
UPDATE `creature_template` SET `ScriptName`='npc_veridian_broodlings' WHERE `entry`=17589;
