-- DB update 2026_02_15_00 -> 2026_02_15_01
-- Remove unused ScriptName from Pure Saronite Deposit
UPDATE `gameobject_template` SET `ScriptName` = '' WHERE `entry` = 195036;
