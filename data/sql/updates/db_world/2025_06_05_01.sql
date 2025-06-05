-- DB update 2025_06_05_00 -> 2025_06_05_01

-- Remove Wrong Auras
UPDATE `creature_addon` SET `auras` = '' WHERE (`guid` IN (129492, 129496, 129497, 129498, 129499));

-- Remove Wrong Unit Flags (Immune to npc and pc "Sniffs")
UPDATE `creature_template` SET `unit_flags` = `unit_flags` &~(256|512) WHERE (`entry` = 28406);
