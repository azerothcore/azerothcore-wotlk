-- DB update 2023_02_11_03 -> 2023_02_11_04
--

DELETE FROM `creature_text` WHERE `CreatureID` = 18881;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(18881,0,0,"%s shatters into shards.",16,0,100,0,0,0,19115,0,"Sundered Rumbler - Emote");

DELETE FROM `smart_scripts` WHERE (`entryorguid` = 18881) AND (`source_type` = 0) AND (`id` IN (2, 3));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(18881, 0, 2, 0, 6, 0, 100, 0, 0, 0, 0, 0, 0, 11, 35310, 3, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, "Sundered Rumbler - On Just Died - Cast \'Summon Sundered Shard\'"),
(18881, 0, 3, 0, 6, 0, 100, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, "Sundered Rumbler - On Just Died - Say Line 0");
