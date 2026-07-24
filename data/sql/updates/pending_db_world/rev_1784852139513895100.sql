-- --------------------------------------------------------------------------------------------
-- Sholazar Basin (Northrend, map 571)
-- The Avalanche sub-Zone Improvements Part 2: Urgreth of the Thousand Tombs
-- NPC Updates, waypoints, etc
-- -------------------------------------------
-- Urgreth of the Thousand Tombs (Entry 28103)
-- Out of combat yell texts and emotes
DELETE FROM `creature_text` WHERE `CreatureID`= 28103 AND `GroupID`= 1;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
    (28103, 1, 0, 'Onward, you maggots!  This land is the Lich King''s now!', 14, 0, 100, 53, 0, 0, 27537, 0, 'Urgreth of the Thousand Tombs'),
    (28103, 1, 1, 'Nothing can stop the Scourge!  Nothing!', 14, 0, 100, 53, 0, 0, 27538, 0, 'Urgreth of the Thousand Tombs'),
    (28103, 1, 2, 'Crush anything that stands in your path!  For the Lich King!', 14, 0, 100, 53, 0, 0, 27539, 0, 'Urgreth of the Thousand Tombs');

DELETE FROM `smart_scripts` WHERE `entryorguid`= 28103 AND `source_type`= 0 AND `id`= 3;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(28103, 0, 3, 0, 1, 0, 100, 0, 90000, 175000, 90000, 175000, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Urgreth of the Thousand Tombs - Out of Combat - Say Line 1');
-- Correct sheathe state
UPDATE `creature_template_addon` SET `bytes2` = 1 WHERE (`entry` = 28103);
