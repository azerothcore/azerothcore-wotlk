INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1631560059547242900');

UPDATE `creature_template` SET `AIName`="", `ScriptName`="npc_sergeant_bly" WHERE `entry`=7604;
UPDATE `creature_template` SET `AIName`="", `ScriptName`="npc_weegli_blastfuse" WHERE `entry`=7607;
UPDATE `gameobject_template` SET `AIName`="", `ScriptName`="go_troll_cage" WHERE `entry` BETWEEN 141070 AND 141074;

DELETE FROM `gossip_menu_option` WHERE `MenuId` IN (940,941);
DELETE FROM `conditions` WHERE `Sourcetypeorreferenceid` IN (14,15) AND `SourceGroup` IN (940,941);

DELETE FROM `smart_scripts` WHERE `entryorguid` IN (7604,7607);
DELETE FROM `smart_scripts` WHERE `entryorguid` BETWEEN 760400 AND 760403;
DELETE FROM `smart_scripts` WHERE `entryorguid` BETWEEN 141070 AND 141074;

DELETE FROM `creature_summon_groups` WHERE `summonerId`=7604;
