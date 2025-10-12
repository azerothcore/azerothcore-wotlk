-- DB update 2025_04_29_00 -> 2025_04_29_01

-- Active SmartAI for female DKs.
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 29030;
