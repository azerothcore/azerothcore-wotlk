-- DB update 2023_12_04_01 -> 2023_12_04_02
--
UPDATE `creature` SET
    `position_x` = -1423.3927,
    `position_y` = -11284.973,
    `position_z` = 8.427056,
    `orientation` = 1.963490843772888183,
    `wander_distance` = 30,
    `MovementType` = 1,
    `VerifiedBuild` = 52237
WHERE `guid` = 63385 AND `id1` = 17661;
