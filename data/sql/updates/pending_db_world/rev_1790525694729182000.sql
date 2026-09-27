-- Onyxian Whelp: UNIT_FLAG_NON_ATTACKABLE until its spawn-in ends (cleared by npc_onyxian_whelp)
UPDATE `creature_template` SET `unit_flags` = `unit_flags` | 2, `VerifiedBuild` = 69933 WHERE `entry` IN (11262, 36566);
