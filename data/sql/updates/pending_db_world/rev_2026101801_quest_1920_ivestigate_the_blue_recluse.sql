-- Fix spawns for quest 'Investigate the Blue Recluse' (ID: 1920)
-- Rift Spawn (ID: 6492) should be distributed across the floors of the tavern, not stacked in the basement.
DELETE FROM `creature` WHERE `id` = 6492 AND `guid` IN (5300683, 5300681, 1976204, 1976203, 1976202, 1976201, 1976200);
INSERT INTO `creature` (`guid`, `id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`) VALUES
(1976200, 6492, 0, -9094.37, 829.467, 115.667, 6.09607),
(1976201, 6492, 0, -9110.85, 830.738, 97.6299, 3.31741),
(1976202, 6492, 0, -9084.07, 838.396, 108.423, 6.06705),
(1976203, 6492, 0, -9063.16, 842.403, 109.197, 4.11140),
(1976204, 6492, 0, -9109.2, 835.441, 105.117, 0.918768),
(5300681, 6492, 0, -9057.1, 829.867, 109.197, 2.68826),
(5300683, 6492, 0, -9088.63, 817.433, 115.668, 1.46249);
