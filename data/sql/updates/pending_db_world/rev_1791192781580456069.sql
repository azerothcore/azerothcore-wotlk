--
DELETE FROM `creature_text` WHERE `CreatureID` IN (18086, 18089, 19946, 20088) AND `GroupID` = 0;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(18086, 0, 0, '%s calls for a nearby slave to assist him!', 16, 0, 100, 0, 0, 0, 17532, 0, 'Darkcrest Taskmaster - On Aggro'),
(18089, 0, 0, '%s calls for a nearby slave to assist him!', 16, 0, 100, 0, 0, 0, 17532, 0, 'Bloodscale Slavedriver - On Aggro'),
(19946, 0, 0, '%s calls for a nearby slave to assist him!', 16, 0, 100, 0, 0, 0, 17532, 0, 'Darkcrest Slaver - On Aggro'),
(20088, 0, 0, '%s calls for a nearby slave to assist him!', 16, 0, 100, 0, 0, 0, 17532, 0, 'Bloodscale Overseer - On Aggro');

DELETE FROM `smart_scripts` WHERE `entryorguid` IN (18086, 18089, 19946, 20088, 18122, 18123) AND `source_type` = 0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(18086, 0, 0, 0, 0, 0, 100, 0, 4000, 4000, 4000, 7000, 0, 0, 11, 34811, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Darkcrest Taskmaster - In Combat - Cast \'Tail Lash\''),
(18086, 0, 1, 0, 0, 0, 100, 0, 6000, 6000, 8000, 13000, 0, 0, 11, 34812, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Darkcrest Taskmaster - In Combat - Cast \'Curse of Nazjatar\''),
(18086, 0, 2, 3, 4, 0, 100, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Darkcrest Taskmaster - On Aggro - Say Line 0'),
(18086, 0, 3, 4, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 64, 1, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Darkcrest Taskmaster - On Aggro - Store Targetlist'),
(18086, 0, 4, 5, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 100, 1, 0, 0, 0, 0, 0, 19, 18122, 25, 0, 0, 0, 0, 0, 0, 'Darkcrest Taskmaster - On Aggro - Send Target List to Closest \'Dreghood Drudge\''),
(18086, 0, 5, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 223, 1, 0, 0, 0, 0, 0, 19, 18122, 25, 0, 0, 0, 0, 0, 0, 'Darkcrest Taskmaster - On Aggro - Do Action ID 1 on Closest \'Dreghood Drudge\''),
(18089, 0, 0, 0, 4, 0, 100, 1, 0, 0, 0, 0, 0, 0, 11, 32064, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Bloodscale Slavedriver - On Aggro - Cast \'Battle Shout\' (No Repeat)'),
(18089, 0, 1, 2, 4, 0, 100, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Bloodscale Slavedriver - On Aggro - Say Line 0'),
(18089, 0, 2, 3, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 64, 1, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Bloodscale Slavedriver - On Aggro - Store Targetlist'),
(18089, 0, 3, 4, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 100, 1, 0, 0, 0, 0, 0, 19, 18123, 25, 0, 0, 0, 0, 0, 0, 'Bloodscale Slavedriver - On Aggro - Send Target List to Closest \'Wrekt Slave\''),
(18089, 0, 4, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 223, 1, 0, 0, 0, 0, 0, 19, 18123, 25, 0, 0, 0, 0, 0, 0, 'Bloodscale Slavedriver - On Aggro - Do Action ID 1 on Closest \'Wrekt Slave\''),
(19946, 0, 0, 0, 0, 0, 100, 0, 6000, 6000, 30000, 35000, 0, 0, 11, 13730, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Darkcrest Slaver - In Combat - Cast \'Demoralizing Shout\' (Phase 1) (No Repeat)'),
(19946, 0, 1, 2, 4, 0, 100, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Darkcrest Slaver - On Aggro - Say Line 0'),
(19946, 0, 2, 3, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 64, 1, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Darkcrest Slaver - On Aggro - Store Targetlist'),
(19946, 0, 3, 4, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 100, 1, 0, 0, 0, 0, 0, 19, 18122, 25, 0, 0, 0, 0, 0, 0, 'Darkcrest Slaver - On Aggro - Send Target List to Closest \'Dreghood Drudge\''),
(19946, 0, 4, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 223, 1, 0, 0, 0, 0, 0, 19, 18122, 25, 0, 0, 0, 0, 0, 0, 'Darkcrest Slaver - On Aggro - Do Action ID 1 on Closest \'Dreghood Drudge\''),
(20088, 0, 0, 0, 0, 0, 100, 0, 2000, 2000, 5000, 5000, 0, 0, 11, 9080, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Bloodscale Overseer - In Combat - Cast \'Hamstring\' (Phase 1) (No Repeat)'),
(20088, 0, 1, 0, 0, 0, 100, 0, 5000, 5000, 10000, 10000, 0, 0, 11, 34812, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Bloodscale Overseer - In Combat - Cast \'Curse of Nazjatar\' (Phase 1) (No Repeat)'),
(20088, 0, 2, 3, 4, 0, 100, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Bloodscale Overseer - On Aggro - Say Line 0'),
(20088, 0, 3, 4, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 64, 1, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Bloodscale Overseer - On Aggro - Store Targetlist'),
(20088, 0, 4, 5, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 100, 1, 0, 0, 0, 0, 0, 19, 18123, 25, 0, 0, 0, 0, 0, 0, 'Bloodscale Overseer - On Aggro - Send Target List to Closest \'Wrekt Slave\''),
(20088, 0, 5, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 223, 1, 0, 0, 0, 0, 0, 19, 18123, 25, 0, 0, 0, 0, 0, 0, 'Bloodscale Overseer - On Aggro - Do Action ID 1 on Closest \'Wrekt Slave\''),
(18122, 0, 0, 0, 4, 0, 100, 1, 0, 0, 0, 0, 0, 0, 11, 41363, 0, 0, 0, 0, 0, 19, 18122, 5, 0, 0, 0, 0, 0, 0, 'Dreghood Drudge - On Aggro - Cast \'41363\' (No Repeat)'),
(18122, 0, 1, 0, 72, 0, 100, 0, 1, 0, 0, 0, 0, 0, 49, 0, 0, 0, 0, 0, 0, 12, 1, 0, 0, 0, 0, 0, 0, 0, 'Dreghood Drudge - On Action 1 Done - Attack Stored Target'),
(18123, 0, 0, 0, 105, 0, 25, 0, 100, 100, 4000, 4000, 0, 5, 11, 11978, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Wrekt Slave - In Combat - Cast \'Kick\' (Phase 1) (No Repeat)'),
(18123, 0, 1, 0, 4, 0, 100, 1, 0, 0, 0, 0, 0, 0, 11, 34789, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Wrekt Slave - On Aggro - Cast \'Shared Bonds\' (Phase 1) (No Repeat)'),
(18123, 0, 2, 0, 72, 0, 100, 0, 1, 0, 0, 0, 0, 0, 49, 0, 0, 0, 0, 0, 0, 12, 1, 0, 0, 0, 0, 0, 0, 0, 'Wrekt Slave - On Action 1 Done - Attack Stored Target');
