-- DB update 2023_04_19_07 -> 2023_04_19_08
-- Revert Fiery Payback 1m ICD.
DELETE FROM `spell_proc_event` WHERE `entry` IN (64349,64350);
