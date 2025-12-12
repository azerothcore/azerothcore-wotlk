-- DB update 2025_11_15_00 -> 2025_11_15_01
-- fix spell focus location for quest 'Will of the Titans'
UPDATE `gameobject` SET `position_x` = 5110.11, `position_y` = 5471.22, `position_z` = -91.84 WHERE `id` = 190781 AND `guid` = 99745;
