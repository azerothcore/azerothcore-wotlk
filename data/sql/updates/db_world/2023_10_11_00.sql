-- DB update 2023_10_10_14 -> 2023_10_11_00
-- Bad Attitude
UPDATE `creature_template` SET `AIName` = '' WHERE `entry` IN (1082,1084,1400,1417);
DELETE FROM `smart_scripts` WHERE `source_type` = 0 AND `entryorguid` IN (1082,1084,1400,1417);
