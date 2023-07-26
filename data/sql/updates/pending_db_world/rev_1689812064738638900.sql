--
UPDATE `creature_template` SET `AIName` = '' WHERE `entry` = 12298;

DELETE FROM `smart_scripts` WHERE (`entryorguid` = 12298) AND (`source_type` = 0);
