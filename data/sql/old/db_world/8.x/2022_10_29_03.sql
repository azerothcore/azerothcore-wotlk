-- DB update 2022_10_29_02 -> 2022_10_29_03
--
-- Lava Spawn (12265)
DELETE FROM `creature_text` WHERE `CreatureID`=12265;
INSERT INTO `creature_text` (`CreatureID`, `Text`, `Type`, `Probability`, `BroadcastTextId`, `comment`) VALUES
(12265, '%s splits into two new Lava Spawns!', 16, 100, 7570, 'Lava Spawn');

UPDATE `creature_template` SET `AiName`='', `ScriptName`='npc_lava_spawn' WHERE `entry`=12265;

DELETE FROM `smart_scripts` WHERE `entryorguid`=12265 AND `source_type`=0;
