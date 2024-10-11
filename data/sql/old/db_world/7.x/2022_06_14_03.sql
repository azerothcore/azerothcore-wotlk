-- DB update 2022_06_14_02 -> 2022_06_14_03
-- Update movement for Tarindralla
UPDATE `creature` SET `wander_distance` = 7, `MovementType` = 1 WHERE `guid` = 47347 AND `id1` = 1992;
