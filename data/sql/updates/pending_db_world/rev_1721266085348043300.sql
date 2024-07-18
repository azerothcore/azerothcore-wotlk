--
DELETE FROM `creature_text` WHERE (`CreatureID` = 22898);
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(22898, 0, 0, 'Supremus acquires a new target!', 41, 0, 100, 0, 0, 0, 21959, 0, 'Supremus'),
(22898, 1, 0, 'Supremus punches the ground in anger!', 41, 0, 100, 53, 0, 0, 21019, 0, 'Supremus'),
(22898, 2, 0, 'The ground begins to crack open!', 41, 0, 100, 0, 0, 0, 21018, 0, 'Supremus'),
(22898, 3, 0, '%s goes into a berserker rage!', 16, 0, 100, 0, 0, 0, 4428, 0, 'Supremus');

UPDATE `creature_model_info` SET `CombatReach` = 40 WHERE `DisplayID` = 21145;

UPDATE `creature_template` SET `AIName` = '', `ScriptName` = 'npc_supremus_punch_invisible_stalker', `speed_run` = 1.28571 WHERE (`entry` = 23095);
DELETE FROM `creature_template_addon` WHERE (`entry` = 23095);
