-- ----------------------------------------------------------------------------
-- Dalaran (Northrend, map 571)
-- Dedication of Honor: hidden until the Lich King is defeated on the realm
-- (any raid size, any difficulty)
-- ----------------------------------------------------------------------------

-- The plaque (202443, single spawn guid 342) stays invisible until worldstate 20009 is set,
-- which instance_icecrown_citadel.cpp latches on the Lich King's defeat. Kept entry-level
-- (`SourceId` = 0) so any future spawn of the entry is covered by the same gate.
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 30 AND `SourceGroup` = 1 AND `SourceEntry` = 202443 AND `SourceId` IN (0, 342);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(30, 1, 202443, 0, 0, 11, 0, 20009, 1, 0, 0, 0, 0, '', 'Dedication of Honor - plaque visible once the realm has defeated the Lich King');

-- Undocumented 3.3.3 change: using the plaque opens gossip menu 11431 ("See the fall of the
-- Lich King.") instead of turning to plaque page 3605. Both `Data7` (pageId) and `Data19`
-- (gossipID) are confirmed against a Runeweaver Square sniff, build 67823 - which also validates
-- the menu option row the gossip event fires on.
UPDATE `gameobject_template` SET `Data7` = 0, `Data19` = 11431, `VerifiedBuild` = 67823 WHERE `entry` = 202443;
UPDATE `gossip_menu_option` SET `VerifiedBuild` = 67823 WHERE `MenuID` = 11431 AND `OptionID` = 0;

-- Plaque SAI, full block:
--   0/1 - the cinematic now runs off the gossip option (event 62), not the plaque click (event 64)
--   2   - unchanged base row; flips the Runeweaver Square fountain to its statue state
DELETE FROM `smart_scripts` WHERE `source_type` = 1 AND `entryorguid` = 202443;
DELETE FROM `smart_scripts` WHERE `source_type` = 9 AND `entryorguid` = 20244300;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(202443, 1, 0, 1, 62, 0, 100, 0, 11431, 0, 0, 0, 0, 0, 64, 1, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Dedication of Honor - On Gossip Option Select - Store Targetlist'),
(202443, 1, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 80, 20244300, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Dedication of Honor - On Link - Run Script'),
(202443, 1, 2, 0, 1, 0, 100, 1, 0, 0, 0, 0, 0, 0, 9, 0, 0, 0, 0, 0, 0, 14, 151164, 202616, 0, 0, 0, 0, 0, 0, 'Dedication of Honor - OOC - Activate Go (No Repeat)'),
(20244300, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 72, 0, 0, 0, 0, 0, 0, 12, 1, 0, 0, 0, 0, 0, 0, 0, 'Dedication of Honor - On Script - Close Gossip'),
(20244300, 9, 1, 0, 0, 0, 100, 0, 1000, 1000, 0, 0, 0, 0, 68, 16, 0, 0, 0, 0, 0, 12, 1, 0, 0, 0, 0, 0, 0, 0, 'Dedication of Honor - On Script - Play Movie 16');

-- Drop the personal-achievement gate on the gossip event: the plaque is hidden outright until the
-- realm kill, and past that anyone who can see it may watch the cinematic.
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 22 AND `SourceGroup` = 1 AND `SourceEntry` = 202443 AND `SourceId` = 1;

-- Event 2 above is what turns the fountain (202616, guid 151164) into the statue. Stock AC gated
-- it on CONDITION_REALM_ACHIEVEMENT "Realm First! Light of Dawn" (4576) - a race that is only ever
-- awarded once per realm and never on an imported DB, so the statue could never appear. Gate it on
-- the same worldstate the plaque uses. SmartAI re-polls a failed condition every 5s
-- (SmartScript::ProcessTimedAction), so the reveal needs no timer of its own.
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 22 AND `SourceGroup` = 3 AND `SourceEntry` = 202443 AND `SourceId` = 1;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(22, 3, 202443, 1, 0, 11, 0, 20009, 1, 0, 0, 0, 0, '', 'Dedication of Honor - reveal the statue once the realm has defeated the Lich King');
