-- DB update 2025_12_27_03 -> 2025_12_27_04
-- Delete prowler script
UPDATE `creature_template` SET `AIName` = '' WHERE `entry` = 118;
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 118) AND (`source_type` = 0);

-- Set to Distance where the howl sound is played
UPDATE `smart_scripts` SET `action_param3` = 1 WHERE `entryorguid` IN (834, 1922, 2729) AND `source_type` = 0 AND `action_param1` = 1018 AND `action_type` = 4;
