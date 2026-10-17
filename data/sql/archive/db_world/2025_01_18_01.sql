-- DB update 2025_01_18_00 -> 2025_01_18_01

-- Change Unit Flags (IMMUNE_TO_PC, IMMUNE_TO_NPC)
UPDATE `creature_template` SET `unit_flags` = `unit_flags`|768 WHERE `entry` IN (25465);
