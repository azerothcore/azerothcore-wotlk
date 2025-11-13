
-- Delete SmartAI
UPDATE `creature_template` SET `AIName` = '' WHERE `entry` = 30066;
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 30066) AND (`source_type` = 0);
