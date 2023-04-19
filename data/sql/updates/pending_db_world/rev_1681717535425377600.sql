-- Revert Fiery Payback 1m ICD.
DELETE FROM `spell_proc_event` WHERE `entry` IN (64349,64350);
