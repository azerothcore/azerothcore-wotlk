-- DB update 2022_08_15_07 -> 2022_08_15_08
--
UPDATE `creature_template` SET `unit_flags` = `unit_flags` | 33554432, `ScriptName` = 'npc_dirt_mound' WHERE `entry` = 15712;

UPDATE `gameobject_template_addon` SET `flags` = `flags` | 16 WHERE `entry` = 180795;
