-- DB update 2022_07_19_01 -> 2022_07_19_02
--
UPDATE `creature` SET `MovementType` = 1, `wander_distance` = 5 WHERE `guid` IN (51879,51914);
UPDATE `creature` SET `MovementType` = 0 WHERE `guid` = 132313;

UPDATE `creature_template` SET `AIName` = 'NullCreatureAI' WHERE `AIName` IN ('NullCreatureAi', 'NullAI');
UPDATE `creature_template` SET `AIName` = 'AggressorAI' WHERE `AIName` = 'AgressorAI';
UPDATE `creature_template` SET `AIName` = '' WHERE `AIName` = 'OutdoorPvPObjectiveAI';
