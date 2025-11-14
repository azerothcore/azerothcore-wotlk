-- Root Cause: PROC_EX_ONLY_FIRST_TICK flag (0x200000) was set in procEx field
-- Remove PROC_EX_ONLY_FIRST_TICK (2097152 / 0x200000) flag
UPDATE `spell_proc_event` SET `procEx` = `procEx` & ~2097152 WHERE `entry` = -11213;
