-- DB update 2025_06_17_03 -> 2025_06_18_00
--
UPDATE `creature_template_addon` SET `auras` = '55708' WHERE `entry` = 29939;
UPDATE `creature_template` SET `ScriptName` = '' WHERE `entry` = 29939;
