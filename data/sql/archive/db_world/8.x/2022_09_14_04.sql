-- DB update 2022_09_14_03 -> 2022_09_14_04
--
UPDATE `creature_template` SET `AiName`='', `ScriptName`='npc_anubisath_warder' WHERE `entry`=15311;
DELETE FROM `smart_scripts` WHERE `entryorguid`=15311 AND `source_type`=0;
