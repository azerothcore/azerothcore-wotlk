--
DELETE FROM `smart_scripts` WHERE `entryorguid` IN (33387,34275) AND `source_type`=0;
UPDATE `creature_template` SET `AIName`='', `ScriptName`='npc_freya_ward_summon' WHERE `entry` IN (33387,34275);
