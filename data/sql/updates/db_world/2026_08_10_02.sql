-- DB update 2026_08_10_01 -> 2026_08_10_02
--
-- IMMUNE_TO_PC and IMMUNE_TO_NPC
UPDATE `creature_template` SET `unit_flags` = `unit_flags` | 256 | 512 WHERE (`entry` = 34068);
-- DISABLE_GRAVITY
UPDATE `creature_template_movement` SET `Flight` = 1 WHERE (`CreatureId` = 34068);
