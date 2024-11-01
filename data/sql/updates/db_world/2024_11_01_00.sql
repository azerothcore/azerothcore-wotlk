-- DB update 2024_10_31_01 -> 2024_11_01_00
-- Syndicate Thief
UPDATE `creature_template` SET `unit_flags` = `unit_flags`&~(262144) WHERE (`entry` = 24477);
