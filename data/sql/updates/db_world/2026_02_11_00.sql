-- DB update 2026_02_10_03 -> 2026_02_11_00
UPDATE `creature_template` SET `unit_flags` = 520, `unit_flags2` = 32 WHERE `entry` IN (31883, 31893, 31894, 31895, 31896, 31897);
