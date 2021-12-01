INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1638396928754731000');

SET @POOL_TEMPLATE = 376;
SET @FREE_GAMEOBJECT = 9765;

-- Clear gameobjects from azerothcore master
-- These can't go between ticks or it doesn't run
DELETE `gameobject`
FROM `gameobject`
INNER JOIN `pool_gameobject` ON pool_gameobject.guid = gameobject.guid
INNER JOIN `pool_template` ON pool_gameobject.pool_entry = pool_template.entry
INNER JOIN `pool_pool` ON pool_template.entry = pool_pool.pool_id
WHERE pool_pool.description LIKE 'Spawn Point%Blasted Lands%' OR pool_pool.description LIKE '%Master Mineral Pool - Blasted Lands%';

DELETE `pool_gameobject`
FROM `pool_gameobject`
INNER JOIN `pool_template` ON pool_gameobject.pool_entry = pool_template.entry
INNER JOIN `pool_pool` ON pool_template.entry = pool_pool.pool_id
WHERE pool_pool.description LIKE 'Spawn Point%Blasted Lands%' OR pool_pool.description LIKE '%Master Mineral Pool - Blasted Lands%';

DELETE `pool_template`
FROM `pool_template`
INNER JOIN `pool_pool` ON pool_template.entry = pool_pool.pool_id
WHERE pool_pool.description LIKE 'Spawn Point%Blasted Lands%' OR pool_pool.description LIKE '%Master Mineral Pool - Blasted Lands%';

DELETE `pool_pool`
FROM `pool_pool`
WHERE pool_pool.description LIKE 'Spawn Point%Blasted Lands%' OR pool_pool.description LIKE '%Master Mineral Pool - Blasted Lands%';

DELETE FROM `pool_template` WHERE `entry` >= @POOL_TEMPLATE AND `entry` <= @POOL_TEMPLATE + 5;
INSERT INTO `pool_template` (`entry`, `max_limit`, `description`) VALUES 
(@POOL_TEMPLATE + 0, 2, 'Mithril, Gold and Truesilver in the Blasted Lands Master'),
(@POOL_TEMPLATE + 1, 1, 'Mithril and Truesilver in the Blasted Lands child pool #1'),
(@POOL_TEMPLATE + 2, 1, 'Gold and Mithril in the Blasted Lands child pool #2'),
(@POOL_TEMPLATE + 3, 1, 'Gold and Mithril in the Blasted Lands child pool #3'),
(@POOL_TEMPLATE + 4, 1, 'Mithril and Truesilver in the Blasted Lands child pool #4'),
(@POOL_TEMPLATE + 5, 15, 'Mithril and Small Thorium pool 35 nodes');

DELETE FROM `pool_pool` WHERE `pool_id` >= @POOL_TEMPLATE + 1 AND `pool_id` <= @POOL_TEMPLATE + 5;
INSERT INTO `pool_pool` (`pool_id`, `mother_pool`, `chance`, `description`) VALUES 
(@POOL_TEMPLATE + 1, @POOL_TEMPLATE, 1, 'Mithril and Truesilver child pool #1'),
(@POOL_TEMPLATE + 2, @POOL_TEMPLATE, 1, 'Gold and Mithril child pool #2'),
(@POOL_TEMPLATE + 3, @POOL_TEMPLATE, 1, 'Gold and Mithril child pool #3'),
(@POOL_TEMPLATE + 4, @POOL_TEMPLATE, 1, 'Mithril and Truesilver child pool #4');

DELETE FROM `pool_gameobject` WHERE `pool_entry` >= @POOL_TEMPLATE + 1 AND `pool_entry` <= @POOL_TEMPLATE + 5;
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES 
(@FREE_GAMEOBJECT := @FREE_GAMEOBJECT + 0, @POOL_TEMPLATE + 1, 0, 'Mithril Deposit'),
(@FREE_GAMEOBJECT := @FREE_GAMEOBJECT + 1, @POOL_TEMPLATE + 1, 0, 'Truesilver Deposit'),
(@FREE_GAMEOBJECT := @FREE_GAMEOBJECT + 1, @POOL_TEMPLATE + 2, 0, 'Gold Deposit'),
(@FREE_GAMEOBJECT := @FREE_GAMEOBJECT + 1, @POOL_TEMPLATE + 2, 0, 'Mithril Deposit'),
(@FREE_GAMEOBJECT := @FREE_GAMEOBJECT + 1, @POOL_TEMPLATE + 3, 0, 'Gold Deposit'),
(@FREE_GAMEOBJECT := @FREE_GAMEOBJECT + 1, @POOL_TEMPLATE + 3, 0, 'Mithril Deposit'),
(@FREE_GAMEOBJECT := @FREE_GAMEOBJECT + 1, @POOL_TEMPLATE + 4, 0, 'Mithril Deposit'),
(@FREE_GAMEOBJECT := @FREE_GAMEOBJECT + 1, @POOL_TEMPLATE + 4, 0, 'Truesilver Deposit'),
(@FREE_GAMEOBJECT := @FREE_GAMEOBJECT + 1, @POOL_TEMPLATE + 5, 0, 'Mithril Deposit'),
(@FREE_GAMEOBJECT := @FREE_GAMEOBJECT + 1, @POOL_TEMPLATE + 5, 0, 'Mithril Deposit'),
(@FREE_GAMEOBJECT := @FREE_GAMEOBJECT + 1, @POOL_TEMPLATE + 5, 0, 'Mithril Deposit'),
(@FREE_GAMEOBJECT := @FREE_GAMEOBJECT + 1, @POOL_TEMPLATE + 5, 0, 'Mithril Deposit'),
(@FREE_GAMEOBJECT := @FREE_GAMEOBJECT + 1, @POOL_TEMPLATE + 5, 0, 'Mithril Deposit'),
(@FREE_GAMEOBJECT := @FREE_GAMEOBJECT + 1, @POOL_TEMPLATE + 5, 0, 'Mithril Deposit'),
(@FREE_GAMEOBJECT := @FREE_GAMEOBJECT + 1, @POOL_TEMPLATE + 5, 0, 'Mithril Deposit'),
(@FREE_GAMEOBJECT := @FREE_GAMEOBJECT + 1, @POOL_TEMPLATE + 5, 0, 'Mithril Deposit'),
(@FREE_GAMEOBJECT := @FREE_GAMEOBJECT + 1, @POOL_TEMPLATE + 5, 0, 'Mithril Deposit'),
(@FREE_GAMEOBJECT := @FREE_GAMEOBJECT + 1, @POOL_TEMPLATE + 5, 0, 'Mithril Deposit'),
(@FREE_GAMEOBJECT := @FREE_GAMEOBJECT + 1, @POOL_TEMPLATE + 5, 0, 'Mithril Deposit'),
(@FREE_GAMEOBJECT := @FREE_GAMEOBJECT + 1, @POOL_TEMPLATE + 5, 0, 'Mithril Deposit'),
(@FREE_GAMEOBJECT := @FREE_GAMEOBJECT + 1, @POOL_TEMPLATE + 5, 0, 'Mithril Deposit'),
(@FREE_GAMEOBJECT := @FREE_GAMEOBJECT + 1, @POOL_TEMPLATE + 5, 0, 'Mithril Deposit'),
(@FREE_GAMEOBJECT := @FREE_GAMEOBJECT + 1, @POOL_TEMPLATE + 5, 0, 'Mithril Deposit'),
(@FREE_GAMEOBJECT := @FREE_GAMEOBJECT + 1, @POOL_TEMPLATE + 5, 0, 'Mithril Deposit'),
(@FREE_GAMEOBJECT := @FREE_GAMEOBJECT + 1, @POOL_TEMPLATE + 5, 0, 'Mithril Deposit'),
(@FREE_GAMEOBJECT := @FREE_GAMEOBJECT + 1, @POOL_TEMPLATE + 5, 0, 'Mithril Deposit'),
(@FREE_GAMEOBJECT := @FREE_GAMEOBJECT + 1, @POOL_TEMPLATE + 5, 0, 'Small Thorium Vein'),
(@FREE_GAMEOBJECT := @FREE_GAMEOBJECT + 1, @POOL_TEMPLATE + 5, 0, 'Small Thorium Vein'),
(@FREE_GAMEOBJECT := @FREE_GAMEOBJECT + 1, @POOL_TEMPLATE + 5, 0, 'Small Thorium Vein'),
(@FREE_GAMEOBJECT := @FREE_GAMEOBJECT + 1, @POOL_TEMPLATE + 5, 0, 'Small Thorium Vein'),
(@FREE_GAMEOBJECT := @FREE_GAMEOBJECT + 1, @POOL_TEMPLATE + 5, 0, 'Small Thorium Vein'),
(@FREE_GAMEOBJECT := @FREE_GAMEOBJECT + 1, @POOL_TEMPLATE + 5, 0, 'Small Thorium Vein'),
(@FREE_GAMEOBJECT := @FREE_GAMEOBJECT + 1, @POOL_TEMPLATE + 5, 0, 'Small Thorium Vein'),
(@FREE_GAMEOBJECT := @FREE_GAMEOBJECT + 1, @POOL_TEMPLATE + 5, 0, 'Small Thorium Vein'),
(@FREE_GAMEOBJECT := @FREE_GAMEOBJECT + 1, @POOL_TEMPLATE + 5, 0, 'Small Thorium Vein'),
(@FREE_GAMEOBJECT := @FREE_GAMEOBJECT + 1, @POOL_TEMPLATE + 5, 0, 'Small Thorium Vein'),
(@FREE_GAMEOBJECT := @FREE_GAMEOBJECT + 1, @POOL_TEMPLATE + 5, 0, 'Small Thorium Vein'),
(@FREE_GAMEOBJECT := @FREE_GAMEOBJECT + 1, @POOL_TEMPLATE + 5, 0, 'Small Thorium Vein'),
(@FREE_GAMEOBJECT := @FREE_GAMEOBJECT + 1, @POOL_TEMPLATE + 5, 0, 'Small Thorium Vein'),
(@FREE_GAMEOBJECT := @FREE_GAMEOBJECT + 1, @POOL_TEMPLATE + 5, 0, 'Small Thorium Vein'),
(@FREE_GAMEOBJECT := @FREE_GAMEOBJECT + 1, @POOL_TEMPLATE + 5, 0, 'Small Thorium Vein'),
(@FREE_GAMEOBJECT := @FREE_GAMEOBJECT + 1, @POOL_TEMPLATE + 5, 0, 'Gold Vein'),
(@FREE_GAMEOBJECT := @FREE_GAMEOBJECT + 1, @POOL_TEMPLATE + 5, 0, 'Gold Vein');

SET @FREE_GAMEOBJECT = 9765;

-- 43 Gameobjects
DELETE FROM `gameobject` WHERE `zoneId` = 4 AND (`id` = 2040 OR `id` = 2047 OR `id` = 1734 OR `id` = 150079 OR `id` = 150082 OR `id` = 324);
DELETE FROM `gameobject` WHERE `guid` >= @FREE_GAMEOBJECT_ENTRY AND `guid` <= @FREE_GAMEOBJECT_ENTRY + 43;
INSERT INTO `gameobject` (`guid`, `id`, `map`, `zoneId`,`position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `state`) VALUES 
(@FREE_GAMEOBJECT := @FREE_GAMEOBJECT + 0, 2040, 0, 4, -11542.7, -2919.17, 14.5303, 4.11898, 0, 0, -0.882947, 0.469473, 1800, 1),
(@FREE_GAMEOBJECT := @FREE_GAMEOBJECT + 1, 2047, 0, 4, -11542.7, -2919.17, 14.5303, 4.11898, 0, 0, -0.882947, 0.469473, 2700, 1),
(@FREE_GAMEOBJECT := @FREE_GAMEOBJECT + 1, 1734, 0, 4, -11347.9, -2880.95, 12.63, 3.90954, 0, 0, -0.927183, 0.374608, 1800, 1),
(@FREE_GAMEOBJECT := @FREE_GAMEOBJECT + 1, 2040, 0, 4, -11347.9, -2880.95, 12.63, 3.90954, 0, 0, -0.927183, 0.374608, 1800, 1),
(@FREE_GAMEOBJECT := @FREE_GAMEOBJECT + 1, 1734, 0, 4, -11253.7, -2698.1, 15.4379, 1.16937, 0, 0, 0.551936, 0.833886, 1800, 1),
(@FREE_GAMEOBJECT := @FREE_GAMEOBJECT + 1, 2040, 0, 4, -11253.7, -2698.1, 15.4379, 1.16937, 0, 0, 0.551936, 0.833886, 1800, 1),
(@FREE_GAMEOBJECT := @FREE_GAMEOBJECT + 1, 2040, 0, 4, -11126.9, -3365.38, 58.9554, 4.67748, 0, 0, -0.719339, 0.694659, 1800, 1),
(@FREE_GAMEOBJECT := @FREE_GAMEOBJECT + 1, 2047, 0, 4, -11126.9, -3365.38, 58.9554, 4.67748, 0, 0, -0.719339, 0.694659, 2700, 1),
(@FREE_GAMEOBJECT := @FREE_GAMEOBJECT + 1, 2040, 0, 4, -11864.1, -3352.51, 17.5933, 2.60053, 0, 0, 0.96363, 0.267241, 1800, 1),
(@FREE_GAMEOBJECT := @FREE_GAMEOBJECT + 1, 2040, 0, 4, -11853.2, -2944.53, 18.2617, 4.53786, 0, 0, -0.766044, 0.642789, 1800, 1),
(@FREE_GAMEOBJECT := @FREE_GAMEOBJECT + 1, 2040, 0, 4, -11733.5, -3170.78, -7.08996, 5.25344, 0, 0, -0.492423, 0.870356, 1800, 1),
(@FREE_GAMEOBJECT := @FREE_GAMEOBJECT + 1, 2040, 0, 4, -11705.4, -2752.11, 12.5473, 1.85005, 0, 0, 0.798635, 0.601815, 1800, 1),
(@FREE_GAMEOBJECT := @FREE_GAMEOBJECT + 1, 2040, 0, 4, -11556.6, -3112.53, 12.1533, 0.698131, 0, 0, 0.34202, 0.939693, 1800, 1),
(@FREE_GAMEOBJECT := @FREE_GAMEOBJECT + 1, 2040, 0, 4, -11487.5, -3406.52, 18.8567, 5.2709, 0, 0, -0.484809, 0.87462, 1800, 1),
(@FREE_GAMEOBJECT := @FREE_GAMEOBJECT + 1, 2040, 0, 4, -11470.4, -3198.2, 24.3378, 5.95157, 0, 0, -0.165047, 0.986286, 1800, 1),
(@FREE_GAMEOBJECT := @FREE_GAMEOBJECT + 1, 2040, 0, 4, -11387.7, -3348.58, 11.8879, 5.18363, 0, 0, -0.522498, 0.852641, 1800, 1),
(@FREE_GAMEOBJECT := @FREE_GAMEOBJECT + 1, 2040, 0, 4, -11303.6, -3203.56, 30.4578, 1.25664, 0, 0, 0.587785, 0.809017, 1800, 1),
(@FREE_GAMEOBJECT := @FREE_GAMEOBJECT + 1, 2040, 0, 4, -11286.7, -3423.87, 10.0321, 0.488691, 0, 0, 0.241921, 0.970296, 1800, 1),
(@FREE_GAMEOBJECT := @FREE_GAMEOBJECT + 1, 2040, 0, 4, -11180.9, -2909.93, 39.0139, 4.41568, 0, 0, -0.803857, 0.594823, 1800, 1),
(@FREE_GAMEOBJECT := @FREE_GAMEOBJECT + 1, 2040, 0, 4, -10942.8, -2822.68, 27.2863, 4.76475, 0, 0, -0.688354, 0.725375, 1800, 1),
(@FREE_GAMEOBJECT := @FREE_GAMEOBJECT + 1, 150079, 0, 4, -10857.4, -3167.36, 47.1372, 0.331611, 0, 0, 0.165047, 0.986286, 1800, 1),
(@FREE_GAMEOBJECT := @FREE_GAMEOBJECT + 1, 150079, 0, 4, -10818.7, -3475.05, -21.4749, 5.65487, 0, 0, -0.309016, 0.951057, 1800, 1),
(@FREE_GAMEOBJECT := @FREE_GAMEOBJECT + 1, 150079, 0, 4, -10801.7, -3064.23, 45.8933, 0.802851, 0, 0, 0.390731, 0.920505, 1800, 1),
(@FREE_GAMEOBJECT := @FREE_GAMEOBJECT + 1, 150079, 0, 4, -10705.5, -3127.19, 29.0701, 4.34587, 0, 0, -0.824126, 0.566406, 1800, 1),
(@FREE_GAMEOBJECT := @FREE_GAMEOBJECT + 1, 150079, 0, 4, -10603.2, -3214.84, -2.70033, 2.87979, 0, 0, 0.991445, 0.130528, 1800, 1),
(@FREE_GAMEOBJECT := @FREE_GAMEOBJECT + 1, 150079, 0, 4, -10481.5, -3269.82, -4.87173, 0.0523589, 0, 0, 0.0261765, 0.999657, 1800, 1),
(@FREE_GAMEOBJECT := @FREE_GAMEOBJECT + 1, 150082, 0, 4, -10732.7, -3276.7, -10.6695, 5.72468, 0, 0, -0.275637, 0.961262, 2700, 1),
(@FREE_GAMEOBJECT := @FREE_GAMEOBJECT + 1, 150082, 0, 4, -10673.9, -3564.52, -33.5804, 4.93928, 0, 0, -0.622514, 0.782609, 2700, 1),
(@FREE_GAMEOBJECT := @FREE_GAMEOBJECT + 1, 150082, 0, 4, -10594.3, -3199.24, 10.6181, 5.67232, 0, 0, -0.300705, 0.953717, 2700, 1),
(@FREE_GAMEOBJECT := @FREE_GAMEOBJECT + 1, 324, 0, 4, -11685.7, -3412.33, 18.409, 3.08918, 0, 0, 0.999657, 0.0262017, 2700, 1),
(@FREE_GAMEOBJECT := @FREE_GAMEOBJECT + 1, 324, 0, 4, -11542.9, -2873.28, 12.1575, 6.14356, 0, 0, -0.0697555, 0.997564, 2700, 1),
(@FREE_GAMEOBJECT := @FREE_GAMEOBJECT + 1, 324, 0, 4, -11513.3, -2965.08, 35.6738, 3.4383, 0, 0, -0.989016, 0.147811, 2700, 1),
(@FREE_GAMEOBJECT := @FREE_GAMEOBJECT + 1, 324, 0, 4, -11377.5, -2688.77, 33.9724, 4.85202, 0, 0, -0.656058, 0.75471, 2700, 1),
(@FREE_GAMEOBJECT := @FREE_GAMEOBJECT + 1, 324, 0, 4, -11309.9, -2952.67, 22.2286, 1.36136, 0, 0, 0.62932, 0.777146, 2700, 1),
(@FREE_GAMEOBJECT := @FREE_GAMEOBJECT + 1, 324, 0, 4, -11307.5, -2520.43, 93.8103, 1.15192, 0, 0, 0.544639, 0.838671, 2700, 1),
(@FREE_GAMEOBJECT := @FREE_GAMEOBJECT + 1, 324, 0, 4, -11270.4, -3305.36, 28.3876, 0.453785, 0, 0, 0.224951, 0.97437, 2700, 1),
(@FREE_GAMEOBJECT := @FREE_GAMEOBJECT + 1, 324, 0, 4, -11234.1, -3451.77, 8.38004, 4.86947, 0, 0, -0.649447, 0.760406, 2700, 1),
(@FREE_GAMEOBJECT := @FREE_GAMEOBJECT + 1, 324, 0, 4, -11232.6, -3480.72, 9.60974, 3.71755, 0, 0, -0.958819, 0.284016, 2700, 1),
(@FREE_GAMEOBJECT := @FREE_GAMEOBJECT + 1, 324, 0, 4, -11219.8, -3391.64, 22.8582, 0.715585, 0, 0, 0.350207, 0.936672, 2700, 1),
(@FREE_GAMEOBJECT := @FREE_GAMEOBJECT + 1, 324, 0, 4, -11203, -2555.16, 108.173, 3.82227, 0, 0, -0.942641, 0.333808, 2700, 1),
(@FREE_GAMEOBJECT := @FREE_GAMEOBJECT + 1, 324, 0, 4, -10873, -2727.42, 9.55622, 5.53269, 0, 0, -0.366501, 0.930418, 2700, 1),
(@FREE_GAMEOBJECT := @FREE_GAMEOBJECT + 1, 1734, 0, 4, -11280.7, -3478.4, 7.66078, 2.04204, 0, 0, 0.85264, 0.522499, 1800, 1),
(@FREE_GAMEOBJECT := @FREE_GAMEOBJECT + 1, 1734, 0, 4, -10831.1, -3691.35, 23.2697, 3.83973, 0, 0, -0.939692, 0.342021, 1800, 1);
