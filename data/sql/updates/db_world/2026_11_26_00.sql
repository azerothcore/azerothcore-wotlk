-- DB update 2026_11_25_04 -> 2026_11_26_00
-- Coilfang Frenzy Corpse: UNIT_FLAG_IMMUNE_TO_PC | UNIT_FLAG_IMMUNE_TO_NPC | UNIT_FLAG_NOT_SELECTABLE (cMaNGOS tbc-db)
UPDATE `creature_template` SET `unit_flags` = `unit_flags` | 33555200 WHERE `entry` = 21689;
