UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` IN (15651, 15652);
DELETE FROM `smart_scripts` WHERE (`entryorguid` IN (15651, 15652)) AND (`action_param1` = 22863);
