-- DB update 2025_09_26_00 -> 2025_09_26_01

-- Remove Phase Mask 1 and add Phasemask 2.
UPDATE `creature` SET `phaseMask` = `phaseMask` &~1 | 2 WHERE `id1` = 28529 AND `guid` IN (128641,128697);
