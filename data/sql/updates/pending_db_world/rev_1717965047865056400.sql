--
UPDATE `creature_template` SET `AIName` = '' WHERE `entry` = 18145;

DELETE FROM `smart_scripts` WHERE (`entryorguid` = 18145) AND (`source_type` = 0);
