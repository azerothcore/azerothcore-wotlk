-- DB update 2026_01_18_02 -> 2026_01_19_00
--
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 24539);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(24539, 0, 0, 0, 0, 0, 100, 0, 3000, 6000, 15000, 22000, 0, 0, 11, 15091, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, '\'Silvermoon\' Harry - In Combat - Cast \'Blast Wave\''),
(24539, 0, 1, 0, 0, 0, 100, 0, 2500, 4000, 4000, 5000, 0, 0, 11, 50183, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, '\'Silvermoon\' Harry - In Combat - Cast \'Scorch\''),
(24539, 0, 2, 0, 62, 0, 100, 0, 9010, 0, 0, 0, 0, 0, 80, 2453900, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, '"Silvermoon" Harry - On Gossip Option "Taruk sent me to collect" Selected - Run Script: Attack'),
(24539, 0, 3, 4, 62, 0, 100, 0, 9011, 0, 0, 0, 0, 0, 56, 34115, 1, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, '"Silvermoon" Harry - On Gossip Option "Pay up, Harry!" Selected - Add Item \'"Silvermoon" Harry\'s Debt\' 1 Time'),
(24539, 0, 4, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 72, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, '"Silvermoon" Harry - On Gossip Option 0 Selected - Close Gossip'),
(24539, 0, 5, 0, 2, 0, 100, 0, 0, 50, 30000, 30000, 0, 0, 80, 2453901, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, '"Silvermoon" Harry - Between 0-50% Health - Run Script: Give Up Fight'),
(24539, 0, 7, 0, 32, 0, 100, 0, 0, 1000000, 15000, 15000, 0, 0, 42, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, '"Silvermoon" Harry - On Damaged by Condition: Player in Quest - Set Invincibility'),
(24539, 0, 8, 0, 32, 0, 100, 0, 0, 1000000, 15000, 15000, 0, 0, 42, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, '"Silvermoon" Harry - On Damaged by Condition: Player NOT in Quest - Remove Invincibility'),
(24539, 0, 9, 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 240, 9010, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, '"Silvermoon" Harry - Actionlist - Reset GossipMenuID to 9010'),
(24539, 0, 10, 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 2, 1888, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, '"Silvermoon" Harry - Actionlist - Reset Faction');

DELETE FROM `smart_scripts` WHERE (`source_type` = 9 AND `entryorguid` = 2453900);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2453900, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, '\'Silvermoon\' Harry - On Script - Say Line 0'),
(2453900, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 83, 131, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, '"Silvermoon" Harry - Actionlist - Remove Npc Flags Gossip & Questgiver & Vendor'),
(2453900, 9, 2, 0, 0, 0, 100, 0, 1200, 1200, 0, 0, 0, 0, 49, 0, 0, 0, 0, 0, 0, 21, 10, 0, 0, 0, 0, 0, 0, 0, '"Silvermoon" Harry - Actionlist - Start Attacking');

DELETE FROM `smart_scripts` WHERE (`source_type` = 9 AND `entryorguid` = 2453901);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2453901, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, '"Silvermoon" Harry - Actionlist - Say Line 1'),
(2453901, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 2, 1080, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, '"Silvermoon" Harry - Actionlist - Set Faction Friendly'),
(2453901, 9, 2, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 24, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, '"Silvermoon" Harry - Actionlist - Evade'),
(2453901, 9, 3, 0, 0, 0, 100, 0, 2400, 2400, 0, 0, 0, 0, 82, 131, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, '"Silvermoon" Harry - Actionlist - Add Npc Flags Gossip & Questgiver & Vendor'),
(2453901, 9, 4, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 240, 9011, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, '"Silvermoon" Harry - Actionlist - Change GossipMenuID to 9011'),
(2453901, 9, 5, 0, 0, 0, 100, 0, 60000, 60000, 0, 0, 0, 0, 240, 9010, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, '"Silvermoon" Harry - Actionlist - Reset GossipMenuID to 9010'),
(2453901, 9, 6, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 2, 1888, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, '"Silvermoon" Harry - Actionlist - Reset Faction');

DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId` = 22) AND (`SourceEntry` = 24539) AND (`SourceId` = 0) AND (`ElseGroup` = 0) AND (`ConditionTypeOrReference` = 47);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(22, 8, 24539, 0, 0, 47, 0, 11464, 8, 0, 0, 0, 0, '', 'Only Play Script if Quest \'Gambling Debt\' (11464) is in progress'),
(22, 9, 24539, 0, 0, 47, 0, 11464, 8, 0, 1, 0, 0, '', 'Only Play Script if Quest \'Gambling Debt\' (11464) is in progress');

DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId` = 15) AND (`SourceGroup` IN (9010,9011)) AND (`ConditionTypeOrReference` = 2) AND (`ConditionValue1` = 34115);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(15, 9010, 0, 0, 0, 2, 0, 34115, 1, 0, 1, 0, 0, '', 'Only Show Gossip Option for quest Gambling Debt (11464) if player does not have Quest Item "Silvermoon" Harry\'s Debt (34115)'),
(15, 9011, 0, 0, 0, 2, 0, 34115, 1, 0, 1, 0, 0, '', 'Only Show Gossip Option for quest Gambling Debt (11464) if player does not have Quest Item "Silvermoon" Harry\'s Debt (34115)');
