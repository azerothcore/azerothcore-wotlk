-- DB update 2023_05_13_11 -> 2023_05_13_12
-- Co-authored-by: aletson <aletson@users.noreply.github.com> https://github.com/TrinityCore/TrinityCore/pull/20630
-- Floon(18588) & Raliq the Drunk(18585) & Sal'salabim(18584)
UPDATE `creature_template` SET `AIName` = 'SmartAI', `ScriptName` = '' WHERE `entry` IN (18588,18585,18584);

-- Floon
DELETE FROM `smart_scripts` WHERE `entryorguid`=18588 AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(18588, 0, 0, 0, 0, 0, 100, 0, 2000, 2000, 30000, 30000, 0, 11, 6726, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Floon - In Combat - Cast \'Silence\''),
(18588, 0, 1, 0, 0, 0, 100, 0, 4000, 4000, 5000, 5000, 0, 11, 9672, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Floon - In Combat - Cast \'Frostbolt\''),
(18588, 0, 2, 0, 0, 0, 100, 0, 9000, 9000, 20000, 20000, 0, 11, 11831, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Floon - In Combat - Cast \'Frost Nova\''),
(18588, 0, 3, 4, 62, 0, 100, 0, 7731, 0, 0, 0, 0, 72, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Floon - On Gossip Option 0 Selected - Close Gossip'),
(18588, 0, 4, 5, 61, 0, 100, 0, 0, 0, 0, 0, 0, 2, 1738, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Floon - On Gossip Option 0 Selected - Set Faction Arrakoa'),
(18588, 0, 5, 6, 61, 0, 100, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Floon - On Gossip Option 0 Selected - Say Line 0'),
(18588, 0, 6, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 49, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Floon - On Gossip Option 0 Selected - Start Attacking'),
(18588, 0, 7, 0, 25, 0, 100, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Floon - On Reset - Set Default Faction');

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 15 AND `SourceGroup` = 7732;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(15, 7732, 0, 0, 0, 9, 0, 10009, 0, 0, 0, 0, 0, '', 'Floon - Show gossip menu 7732 option id 0 if quest Crackin\' Some Skulls has been taken.');

-- Raliq the Drunk
UPDATE `creature_template_addon` SET `bytes2` = 1 WHERE `entry` = 18585;

DELETE FROM `smart_scripts` WHERE `entryorguid`=18585 AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(18585, 0, 0, 0, 0, 0, 100, 0, 5000, 5000, 15000, 15000, 0, 11, 10966, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Raliq the Drunk - In Combat - Cast \'Uppercut\''),
(18585, 0, 1, 2, 62, 0, 100, 0, 7729, 0, 0, 0, 0, 72, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Raliq the Drunk - On Gossip Option 0 Selected - Close Gossip'),
(18585, 0, 2, 3, 61, 0, 100, 0, 0, 0, 0, 0, 0, 2, 45, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Raliq the Drunk - On Gossip Option 0 Selected - Set Faction Ogre'),
(18585, 0, 3, 4, 61, 0, 100, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Raliq the Drunk - On Gossip Option 0 Selected - Say Line 0'),
(18585, 0, 4, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 49, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Raliq the Drunk - On Gossip Option 0 Selected - Start Attacking'),
(18585, 0, 5, 0, 25, 0, 100, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Raliq the Drunk - On Reset - Set Default Faction'),
(18585, 0, 6, 0, 1, 0, 100, 0, 0, 0, 3600, 5000, 0, 5, 92, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Raliq the Drunk - Out of Combat - Play Emote 92 (ONESHOT_EAT_NOSHEATHE)');

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 15 AND `SourceGroup` = 7729;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(15, 7729, 0, 0, 0, 9, 0, 10009, 0, 0, 0, 0, 0, '', 'Raliq the Drunk - Show gossip menu 7729 option id 0 if quest Crackin\' Some Skulls has been taken.');

-- Sal'salabim
DELETE FROM `smart_scripts` WHERE `entryorguid`=18584 AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(18584, 0, 0, 0, 9, 0, 100, 0, 8, 40, 15000, 15000, 0, 11, 31705, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Sal\'salabim - Within 8-40 Range - Cast \'Magnetic Pull\''),
(18584, 0, 1, 2, 62, 0, 100, 0, 7725, 0, 0, 0, 0, 72, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Sal\'salabim - On Gossip Option 0 Selected - Close Gossip'),
(18584, 0, 2, 3, 61, 0, 100, 0, 0, 0, 0, 0, 0, 2, 90, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Sal\'salabim - On Gossip Option 0 Selected - Set Faction Demon'),
(18584, 0, 3, 4, 61, 0, 100, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Sal\'salabim - On Gossip Option 0 Selected - Say Line 0'),
(18584, 0, 4, 5, 61, 0, 100, 0, 0, 0, 0, 0, 0, 49, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Sal\'salabim - On Gossip Option 0 Selected - Start Attacking'),
(18584, 0, 5, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 42, 0, 19, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Sal\'salabim - On Gossip Option 0 Selected - Set Invincibility Hp 19%'),
(18584, 0, 6, 7, 2, 0, 100, 1, 0, 20, 0, 0, 0, 15, 10004, 0, 0, 0, 0, 0, 24, 0, 0, 0, 0, 0, 0, 0, 0, 'Sal\'salabim - On Health Below 20% - Quest Credit \'Patience and Understanding\''),
(18584, 0, 7, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 24, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Sal\'salabim - On Health Below 20% - Evade'),
(18584, 0, 8, 0, 25, 0, 100, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Sal\'salabim - On Reset - Set Default Faction');

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 15 AND `SourceGroup` = 7725;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(15, 7725, 0, 0, 0, 9, 0, 10004, 0, 0, 0, 0, 0, '', 'Sal\'salabim - Show gossip menu 7725 option id 0 if quest Patience and Understanding has been taken.');
