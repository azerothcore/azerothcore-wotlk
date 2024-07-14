UPDATE `creature_template` SET `AIName` = '' WHERE `entry` IN (2307, 11940, 11941, 11943, 19064, 32743, 37072);

DELETE FROM `smart_scripts` WHERE `entryorguid` IN (2307, 11940, 11941, 11943, 19064, 32743, 37072) AND `source_type` = 0;
