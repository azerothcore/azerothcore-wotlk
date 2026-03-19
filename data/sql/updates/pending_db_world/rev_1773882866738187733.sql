-- Remove incorrect IMMUNE_TO_PC from Malygos spawn flags
UPDATE `creature` SET `unit_flags` = 0 WHERE `guid` = 132313 AND `id1` = 28859;
