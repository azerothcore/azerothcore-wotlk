-- DB update 2022_09_03_00 -> 2022_09_03_01
--
UPDATE `creature` SET `MovementType`=1, `wander_distance`=3 WHERE `id1`=15233 AND `map`=531 AND `guid` NOT IN (87595,87596);
