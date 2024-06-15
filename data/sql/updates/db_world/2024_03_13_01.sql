-- DB update 2024_03_13_00 -> 2024_03_13_01
-- fix phaseMask of two 'Bench' spawns
UPDATE `gameobject` SET `phaseMask` = 2 WHERE (`guid` IN (57773, 57784));
