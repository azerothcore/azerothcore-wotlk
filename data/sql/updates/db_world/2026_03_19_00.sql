-- DB update 2026_03_18_02 -> 2026_03_19_00
-- Remove incorrect IMMUNE_TO_PC from Malygos spawn flags
UPDATE `creature` SET `unit_flags` = 0 WHERE `guid` = 132313 AND `id1` = 28859;
