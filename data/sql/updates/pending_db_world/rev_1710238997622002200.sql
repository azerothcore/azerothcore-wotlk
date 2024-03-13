-- fix phaseMask of two 'Bench' spawns
UPDATE `gameobject` SET `phaseMask` = 2 WHERE (`guid` IN (57773, 57784));
