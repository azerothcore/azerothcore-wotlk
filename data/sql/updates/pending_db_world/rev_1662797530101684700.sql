--
UPDATE `creature_template` SET `AIName`='', `ScriptName`='npc_ahnqiraji_critter' WHERE `entry` IN (15316,15317);
DELETE FROM `smart_scripts` WHERE `entryorguid` IN (15316,15317) AND `source_type`=0;
