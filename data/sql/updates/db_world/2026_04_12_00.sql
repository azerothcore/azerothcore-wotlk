-- DB update 2026_04_11_00 -> 2026_04_12_00
UPDATE `creature_template` SET `unit_flags` = `unit_flags` &~ 0x00040000 WHERE `entry` = 24722;
UPDATE `creature_template` SET `unit_flags` = `unit_flags` &~ (0x00000100|0x00000200) WHERE `entry` = 25552;
UPDATE `creature_template_addon` SET `auras` = '25900' WHERE `entry` IN (24722, 25552);
