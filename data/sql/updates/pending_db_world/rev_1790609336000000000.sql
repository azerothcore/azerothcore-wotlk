UPDATE `gameobject_template` SET `AIName` = '', `ScriptName` = 'go_personal_mole_machine' WHERE `entry` = 190022;

DELETE FROM `smart_scripts` WHERE (`entryorguid` = 190022) AND (`source_type` = 1);
