-- DB update 2023_10_17_00 -> 2023_10_17_01
-- Minor Manifestation of Earth
UPDATE `creature_template` SET `AIName` = '' WHERE `entry` = 5891;
UPDATE `creature_template_addon` SET `auras` = '8203' WHERE (`entry` = 5891);

DELETE FROM `smart_scripts` WHERE (`entryorguid` = 5891) AND (`source_type` = 0);
