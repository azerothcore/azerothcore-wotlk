--
UPDATE `gameobject_template` SET `AIName` = '', `ScriptName` = 'go_ancient_skull_pile' WHERE `entry` = 185928;
DELETE FROM `smart_scripts` WHERE `entryorguid` = 185928 AND `source_type` = 1;
