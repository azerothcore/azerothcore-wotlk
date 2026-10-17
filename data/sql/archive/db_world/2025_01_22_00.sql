-- DB update 2025_01_19_02 -> 2025_01_22_00

-- Change creature template flags (before: IMMUNE_TO_PC, IMMUNE_TO_NPC, NOT_SELECTABLE. now: STUNNED, NOT_SELECTABLE).
UPDATE `creature_template` SET `unit_flags`=`unit_flags`& ~33555200 WHERE (`entry` = 24722);
UPDATE `creature_template` SET `unit_flags`=`unit_flags`|33816576 WHERE (`entry` = 24722);

-- Add Rooted and Flight (Sniffed Flags).
UPDATE `creature_template_movement` SET `Flight` = 1, `Rooted` = 1 WHERE (`CreatureId` = 24722);
