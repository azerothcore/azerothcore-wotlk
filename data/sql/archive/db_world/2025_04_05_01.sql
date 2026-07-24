-- DB update 2025_04_05_00 -> 2025_04_05_01
--
-- Remove aura 45769 Sunwell Radiance
UPDATE `creature_template_addon` SET `auras` = '' WHERE `entry` IN (25363, 25367, 25368, 25369, 25370, 25371, 25373, 25485, 25486, 25506, 25508, 25509, 25592, 25593, 25595, 25597, 25599, 25798, 25799, 25824, 25837, 25851);
UPDATE `creature_addon` SET `auras` = '' WHERE `guid` IN (48194, 48396, 48397, 48401, 48402, 48403, 48404);
