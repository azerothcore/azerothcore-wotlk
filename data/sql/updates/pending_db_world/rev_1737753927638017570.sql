-- Add pure energy immune script for Vex
UPDATE `creature_template` SET `ScriptName` = 'npc_pure_energy' WHERE (`entry` = 24745);
-- AOE_IMMUNE Flag for pure energy
UPDATE `creature_template` SET `flags_extra` = (`flags_extra` | 4194304) WHERE (`entry` = 24745);
