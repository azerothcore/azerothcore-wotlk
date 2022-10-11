--
UPDATE `creature_template` SET `AIName`='', `ScriptName`='npc_theradrim_guardian' WHERE `entry`=11784;

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 11784);
