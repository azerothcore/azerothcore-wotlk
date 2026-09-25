-- DB update 2025_03_28_00 -> 2025_03_29_00
-- Matches the Heroic Faction to the base brann, Adds "Brann Bronzebeard" (1) [Heroic] to Heroic Version | 32'052 => 40'065 HP
UPDATE `creature_template` SET `faction` = 1665, `difficulty_entry_1` = 31366 WHERE (`entry` = 28070);
