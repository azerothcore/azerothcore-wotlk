-- Removes Rock Shell ability
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 4661;
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 4661) AND (`source_type` = 0);
