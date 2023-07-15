--
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` IN (22039, 22482); 
DELETE FROM `smart_scripts` WHERE `entryorguid` IN (22038, 22482) AND (`source_type` = 0) AND (`id` IN (12));

