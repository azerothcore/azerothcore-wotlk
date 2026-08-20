-- DB update 2026_08_19_03 -> 2026_08_19_04
--
UPDATE `conditions` SET `ElseGroup` = 2 WHERE (`SourceTypeOrReferenceId` = 17) AND (`SourceGroup` = 0) AND (`SourceEntry` = 49243) AND (`SourceId` = 0) AND (`ElseGroup` = 1) AND (`ConditionTypeOrReference` = 31) AND (`ConditionTarget` = 1) AND (`ConditionValue1` = 3) AND (`ConditionValue2` = 27682) AND (`ConditionValue3` = 0);

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 27629);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(27629, 0, 0, 0, 25, 0, 100, 512, 0, 0, 0, 0, 0, 0, 60, 1, 350, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Wyrmrest Defender - On Reset - Set Fly On'),
(27629, 0, 1, 2, 62, 0, 100, 512, 9568, 0, 0, 0, 0, 0, 134, 49207, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Wyrmrest Defender - On Gossip Option Selected - Invoker Cast \'Defending Wyrmrest Temple: Summon Wyrmrest Defender\''),
(27629, 0, 2, 0, 61, 0, 100, 512, 0, 0, 0, 0, 0, 0, 72, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Wyrmrest Defender - On Gossip Option Selected - Close Gossip'),
(27629, 0, 3, 0, 29, 0, 100, 512, 0, 0, 0, 0, 0, 0, 21, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Wyrmrest Defender - On Charmed - Disable Combat Movement'),
(27629, 0, 4, 0, 5, 0, 25, 512, 0, 0, 0, 0, 0, 0, 1, 1, 0, 1, 0, 0, 0, 23, 0, 0, 0, 0, 0, 0, 0, 0, 'Wyrmrest Defender - On Killed Unit - Say Line 1'),
(27629, 0, 5, 0, 27, 0, 100, 512, 0, 0, 0, 0, 0, 0, 1, 0, 0, 1, 0, 0, 0, 23, 0, 0, 0, 0, 0, 0, 0, 0, 'Wyrmrest Defender - On Passenger Boarded - Say Line 0'),
(27629, 0, 6, 0, 2, 0, 100, 512, 0, 30, 60000, 60000, 0, 0, 1, 2, 0, 1, 0, 0, 0, 23, 0, 0, 0, 0, 0, 0, 0, 0, 'Wyrmrest Defender - Between 0-30% Health - Say Line 2');

DELETE FROM `creature_text` WHERE (`CreatureID` = 27629) AND (`GroupID` IN (2));
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(27629, 2, 0, 'We should get out of here. I need to renew!', 42, 0, 100, 0, 0, 0, 28879, 0, 'Wyrmrest Defender'),
(27629, 2, 1, 'I need to heal!', 42, 0, 100, 0, 0, 0, 28878, 0, 'Wyrmrest Defender'),
(27629, 2, 2, 'I think it\'s time that I cast my renew!', 42, 0, 100, 0, 0, 0, 28880, 0, 'Wyrmrest Defender');
