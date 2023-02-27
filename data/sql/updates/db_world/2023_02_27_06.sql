-- DB update 2023_02_27_05 -> 2023_02_27_06
--
UPDATE `creature_template` SET `ScriptName` = 'npc_malchezaar_axe', `unit_flags` = `unit_flags`|33554432 WHERE `entry` = 17650;
UPDATE `creature_template` SET `ScriptName` = 'npc_netherspite_infernal' WHERE `entry` = 17646;
UPDATE `creature_template` SET `flags_extra` = `flags_extra` |2147483648 WHERE `entry` = 15690;
