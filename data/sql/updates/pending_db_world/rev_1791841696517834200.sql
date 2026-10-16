--
-- Barrett Ramsey is summoned per stage instead of standing in the arena
DELETE FROM `creature` WHERE (`id` = 34816) AND (`guid` = 202957);

UPDATE `creature_template` SET `gossip_menu_id` = 10599, `npcflag` = 1, `unit_flags` = 768, `AIName` = 'SmartAI', `ScriptName` = '', `VerifiedBuild` = 69933 WHERE (`entry` = 34816);
UPDATE `creature_template` SET `gossip_menu_id` = 10704, `npcflag` = 1, `AIName` = 'SmartAI', `ScriptName` = '' WHERE (`entry` = 35909);
UPDATE `creature_template` SET `AIName` = 'SmartAI', `ScriptName` = '', `VerifiedBuild` = 69933 WHERE (`entry` IN (35035, 35766));
UPDATE `creature_template` SET `AIName` = 'SmartAI', `ScriptName` = '' WHERE (`entry` = 35770);
UPDATE `creature_template` SET `gossip_menu_id` = 10692, `npcflag` = 1, `AIName` = 'SmartAI', `ScriptName` = '' WHERE (`entry` = 35771);

-- The final menu option starts the stage once, then Barrett runs to the exit and despawns
-- Instance data 2 is TYPE_ANNOUNCER_GOSSIP_SELECT; action 1 is the instance asking him to leave
DELETE FROM `smart_scripts` WHERE (`entryorguid` IN (34816, 35909, 35035, 35766, 35770, 35771)) AND (`source_type` = 0);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(34816, 0, 0, 2, 62, 0, 100, 0, 10600, 0, 0, 0, 0, 0, 72, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Barrett Ramsey - On Gossip Option 0 Selected - Close Gossip'),
(34816, 0, 1, 2, 62, 0, 100, 0, 10600, 1, 0, 0, 0, 0, 72, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Barrett Ramsey - On Gossip Option 1 Selected - Close Gossip'),
(34816, 0, 2, 3, 61, 0, 100, 1, 0, 0, 0, 0, 0, 0, 34, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Barrett Ramsey - On Link - Set Instance Data 2 to 0 (No Repeat)'),
(34816, 0, 3, 4, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 83, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Barrett Ramsey - On Link - Remove Npc Flag Gossip'),
(34816, 0, 4, 5, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 18, 33554432, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Barrett Ramsey - On Link - Set Flag Not Selectable'),
(34816, 0, 5, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 69, 1, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 563.5371, 78.77657, 395.2087, 0, 'Barrett Ramsey - On Link - Move To Position'),
(34816, 0, 6, 0, 34, 0, 100, 0, 8, 1, 0, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Barrett Ramsey - On Reached Point 1 - Despawn Instant'),
(35909, 0, 0, 2, 62, 0, 100, 0, 10600, 0, 0, 0, 0, 0, 72, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Barrett Ramsey - On Gossip Option 0 Selected - Close Gossip'),
(35909, 0, 1, 2, 62, 0, 100, 0, 10600, 1, 0, 0, 0, 0, 72, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Barrett Ramsey - On Gossip Option 1 Selected - Close Gossip'),
(35909, 0, 2, 3, 61, 0, 100, 1, 0, 0, 0, 0, 0, 0, 34, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Barrett Ramsey - On Link - Set Instance Data 2 to 0 (No Repeat)'),
(35909, 0, 3, 4, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 83, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Barrett Ramsey - On Link - Remove Npc Flag Gossip'),
(35909, 0, 4, 5, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 18, 33554432, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Barrett Ramsey - On Link - Set Flag Not Selectable'),
(35909, 0, 5, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 69, 1, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 563.5371, 78.77657, 395.2087, 0, 'Barrett Ramsey - On Link - Move To Position'),
(35909, 0, 6, 0, 34, 0, 100, 0, 8, 1, 0, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Barrett Ramsey - On Reached Point 1 - Despawn Instant'),
(35035, 0, 0, 2, 62, 0, 100, 0, 10610, 0, 0, 0, 0, 0, 72, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Barrett Ramsey - On Gossip Option 0 Selected - Close Gossip'),
(35035, 0, 1, 2, 62, 0, 100, 0, 10610, 1, 0, 0, 0, 0, 72, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Barrett Ramsey - On Gossip Option 1 Selected - Close Gossip'),
(35035, 0, 2, 3, 61, 0, 100, 1, 0, 0, 0, 0, 0, 0, 34, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Barrett Ramsey - On Link - Set Instance Data 2 to 0 (No Repeat)'),
(35035, 0, 3, 4, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 83, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Barrett Ramsey - On Link - Remove Npc Flag Gossip'),
(35035, 0, 4, 5, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 18, 33554432, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Barrett Ramsey - On Link - Set Flag Not Selectable'),
(35035, 0, 5, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 69, 1, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 563.5371, 78.77657, 395.2087, 0, 'Barrett Ramsey - On Link - Move To Position'),
(35035, 0, 6, 0, 34, 0, 100, 0, 8, 1, 0, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Barrett Ramsey - On Reached Point 1 - Despawn Instant'),
(35766, 0, 0, 2, 62, 0, 100, 0, 10687, 0, 0, 0, 0, 0, 72, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Barrett Ramsey - On Gossip Option 0 Selected - Close Gossip'),
(35766, 0, 1, 2, 62, 0, 100, 0, 10687, 1, 0, 0, 0, 0, 72, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Barrett Ramsey - On Gossip Option 1 Selected - Close Gossip'),
(35766, 0, 2, 3, 61, 0, 100, 1, 0, 0, 0, 0, 0, 0, 34, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Barrett Ramsey - On Link - Set Instance Data 2 to 0 (No Repeat)'),
(35766, 0, 3, 4, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 83, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Barrett Ramsey - On Link - Remove Npc Flag Gossip'),
(35766, 0, 4, 5, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 18, 33554432, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Barrett Ramsey - On Link - Set Flag Not Selectable'),
(35766, 0, 5, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 69, 1, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 563.5371, 78.77657, 395.2087, 0, 'Barrett Ramsey - On Link - Move To Position'),
(35766, 0, 6, 0, 34, 0, 100, 0, 8, 1, 0, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Barrett Ramsey - On Reached Point 1 - Despawn Instant'),
(35770, 0, 0, 2, 62, 0, 100, 0, 10688, 0, 0, 0, 0, 0, 72, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Barrett Ramsey - On Gossip Option 0 Selected - Close Gossip'),
(35770, 0, 1, 2, 62, 0, 100, 0, 10688, 1, 0, 0, 0, 0, 72, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Barrett Ramsey - On Gossip Option 1 Selected - Close Gossip'),
(35770, 0, 2, 3, 61, 0, 100, 1, 0, 0, 0, 0, 0, 0, 34, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Barrett Ramsey - On Link - Set Instance Data 2 to 0 (No Repeat)'),
(35770, 0, 3, 4, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 83, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Barrett Ramsey - On Link - Remove Npc Flag Gossip'),
(35770, 0, 4, 5, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 18, 33554432, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Barrett Ramsey - On Link - Set Flag Not Selectable'),
(35770, 0, 5, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 69, 1, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 563.5371, 78.77657, 395.2087, 0, 'Barrett Ramsey - On Link - Move To Position'),
(35770, 0, 6, 0, 34, 0, 100, 0, 8, 1, 0, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Barrett Ramsey - On Reached Point 1 - Despawn Instant'),
(35771, 0, 0, 2, 62, 0, 100, 0, 10693, 0, 0, 0, 0, 0, 72, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Barrett Ramsey - On Gossip Option 0 Selected - Close Gossip'),
(35771, 0, 2, 3, 61, 0, 100, 1, 0, 0, 0, 0, 0, 0, 34, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Barrett Ramsey - On Link - Set Instance Data 2 to 0 (No Repeat)'),
(35771, 0, 3, 4, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 83, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Barrett Ramsey - On Link - Remove Npc Flag Gossip'),
(35771, 0, 4, 5, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 18, 33554432, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Barrett Ramsey - On Link - Set Flag Not Selectable'),
(35771, 0, 5, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 69, 1, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 563.5371, 78.77657, 395.2087, 0, 'Barrett Ramsey - On Link - Move To Position'),
(35771, 0, 6, 0, 34, 0, 100, 0, 8, 1, 0, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Barrett Ramsey - On Reached Point 1 - Despawn Instant'),
(35771, 0, 7, 4, 72, 0, 100, 0, 1, 0, 0, 0, 0, 0, 83, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Barrett Ramsey - On Action 1 Done - Remove Npc Flag Gossip');

UPDATE `gossip_menu_option` SET `VerifiedBuild` = 69933 WHERE (`MenuID` IN (10599, 10600, 10609, 10610)) AND (`OptionID` = 0);
UPDATE `npc_text` SET `VerifiedBuild` = 69933 WHERE (`ID` IN (14664, 14665, 14678, 14680));

DELETE FROM `gossip_menu` WHERE (`MenuID` IN (10599, 10600, 10609, 10610, 10678, 10679, 10687, 10688, 10692, 10693, 10704, 10705, 10706));
INSERT INTO `gossip_menu` (`MenuID`, `TextID`) VALUES
(10599, 14664),
(10599, 14667),
(10600, 14665),
(10600, 14668),
(10609, 14678),
(10609, 14679),
(10610, 14680),
(10610, 14682),
(10678, 14813),
(10678, 14815),
(10679, 14819),
(10679, 14820),
(10687, 14814),
(10687, 14816),
(10688, 14821),
(10688, 14822),
(10692, 14828),
(10693, 14829),
(10704, 14667),
(10704, 14850),
(10705, 14852),
(10706, 14853);

-- Boss state FAIL (2) on Northrend Beasts (0), Lord Jaraxxus (1), Faction Champions (2) and Twin Val'kyr (3) switches Barrett to his retry text
DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId` IN (14, 15)) AND (`SourceGroup` IN (10599, 10600, 10609, 10610, 10678, 10679, 10687, 10688, 10704));
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(14, 10599, 14664, 0, 0, 13, 0, 0, 2, 2, 1, 0, 0, '', 'Barrett Ramsey - Show gossip text if Northrend Beasts were not failed'),
(14, 10599, 14667, 0, 0, 13, 0, 0, 2, 2, 0, 0, 0, '', 'Barrett Ramsey - Show gossip text if Northrend Beasts were failed'),
(14, 10600, 14665, 0, 0, 13, 0, 0, 2, 2, 1, 0, 0, '', 'Barrett Ramsey - Show gossip text if Northrend Beasts were not failed'),
(14, 10600, 14668, 0, 0, 13, 0, 0, 2, 2, 0, 0, 0, '', 'Barrett Ramsey - Show gossip text if Northrend Beasts were failed'),
(14, 10609, 14678, 0, 0, 13, 0, 1, 2, 2, 1, 0, 0, '', 'Barrett Ramsey - Show gossip text if Lord Jaraxxus was not failed'),
(14, 10609, 14679, 0, 0, 13, 0, 1, 2, 2, 0, 0, 0, '', 'Barrett Ramsey - Show gossip text if Lord Jaraxxus was failed'),
(14, 10610, 14680, 0, 0, 13, 0, 1, 2, 2, 1, 0, 0, '', 'Barrett Ramsey - Show gossip text if Lord Jaraxxus was not failed'),
(14, 10610, 14682, 0, 0, 13, 0, 1, 2, 2, 0, 0, 0, '', 'Barrett Ramsey - Show gossip text if Lord Jaraxxus was failed'),
(14, 10678, 14813, 0, 0, 13, 0, 2, 2, 2, 1, 0, 0, '', 'Barrett Ramsey - Show gossip text if Faction Champions were not failed'),
(14, 10678, 14815, 0, 0, 13, 0, 2, 2, 2, 0, 0, 0, '', 'Barrett Ramsey - Show gossip text if Faction Champions were failed'),
(14, 10687, 14814, 0, 0, 13, 0, 2, 2, 2, 1, 0, 0, '', 'Barrett Ramsey - Show gossip text if Faction Champions were not failed'),
(14, 10687, 14816, 0, 0, 13, 0, 2, 2, 2, 0, 0, 0, '', 'Barrett Ramsey - Show gossip text if Faction Champions were failed'),
(14, 10679, 14819, 0, 0, 13, 0, 3, 2, 2, 1, 0, 0, '', 'Barrett Ramsey - Show gossip text if Twin Val''kyr were not failed'),
(14, 10679, 14820, 0, 0, 13, 0, 3, 2, 2, 0, 0, 0, '', 'Barrett Ramsey - Show gossip text if Twin Val''kyr were failed'),
(14, 10688, 14821, 0, 0, 13, 0, 3, 2, 2, 1, 0, 0, '', 'Barrett Ramsey - Show gossip text if Twin Val''kyr were not failed'),
(14, 10688, 14822, 0, 0, 13, 0, 3, 2, 2, 0, 0, 0, '', 'Barrett Ramsey - Show gossip text if Twin Val''kyr were failed'),
(14, 10704, 14850, 0, 0, 13, 0, 0, 2, 2, 1, 0, 0, '', 'Barrett Ramsey - Show gossip text if Northrend Beasts were not failed'),
(14, 10704, 14667, 0, 0, 13, 0, 0, 2, 2, 0, 0, 0, '', 'Barrett Ramsey - Show gossip text if Northrend Beasts were failed'),
(15, 10599, 0, 0, 0, 13, 0, 0, 2, 2, 1, 0, 0, '', 'Barrett Ramsey - Show gossip option if Northrend Beasts were not failed'),
(15, 10599, 1, 0, 0, 13, 0, 0, 2, 2, 0, 0, 0, '', 'Barrett Ramsey - Show gossip option if Northrend Beasts were failed'),
(15, 10600, 0, 0, 0, 13, 0, 0, 2, 2, 1, 0, 0, '', 'Barrett Ramsey - Show gossip option if Northrend Beasts were not failed'),
(15, 10600, 1, 0, 0, 13, 0, 0, 2, 2, 0, 0, 0, '', 'Barrett Ramsey - Show gossip option if Northrend Beasts were failed'),
(15, 10609, 0, 0, 0, 13, 0, 1, 2, 2, 1, 0, 0, '', 'Barrett Ramsey - Show gossip option if Lord Jaraxxus was not failed'),
(15, 10609, 1, 0, 0, 13, 0, 1, 2, 2, 0, 0, 0, '', 'Barrett Ramsey - Show gossip option if Lord Jaraxxus was failed'),
(15, 10610, 0, 0, 0, 13, 0, 1, 2, 2, 1, 0, 0, '', 'Barrett Ramsey - Show gossip option if Lord Jaraxxus was not failed'),
(15, 10610, 1, 0, 0, 13, 0, 1, 2, 2, 0, 0, 0, '', 'Barrett Ramsey - Show gossip option if Lord Jaraxxus was failed'),
(15, 10678, 0, 0, 0, 13, 0, 2, 2, 2, 1, 0, 0, '', 'Barrett Ramsey - Show gossip option if Faction Champions were not failed'),
(15, 10678, 1, 0, 0, 13, 0, 2, 2, 2, 0, 0, 0, '', 'Barrett Ramsey - Show gossip option if Faction Champions were failed'),
(15, 10687, 0, 0, 0, 13, 0, 2, 2, 2, 1, 0, 0, '', 'Barrett Ramsey - Show gossip option if Faction Champions were not failed'),
(15, 10687, 1, 0, 0, 13, 0, 2, 2, 2, 0, 0, 0, '', 'Barrett Ramsey - Show gossip option if Faction Champions were failed'),
(15, 10679, 0, 0, 0, 13, 0, 3, 2, 2, 1, 0, 0, '', 'Barrett Ramsey - Show gossip option if Twin Val''kyr were not failed'),
(15, 10679, 1, 0, 0, 13, 0, 3, 2, 2, 0, 0, 0, '', 'Barrett Ramsey - Show gossip option if Twin Val''kyr were failed'),
(15, 10688, 0, 0, 0, 13, 0, 3, 2, 2, 1, 0, 0, '', 'Barrett Ramsey - Show gossip option if Twin Val''kyr were not failed'),
(15, 10688, 1, 0, 0, 13, 0, 3, 2, 2, 0, 0, 0, '', 'Barrett Ramsey - Show gossip option if Twin Val''kyr were failed'),
(15, 10704, 0, 0, 0, 13, 0, 0, 2, 2, 1, 0, 0, '', 'Barrett Ramsey - Show gossip option if Northrend Beasts were not failed'),
(15, 10704, 0, 0, 0, 17, 0, 3916, 0, 0, 0, 0, 0, '', 'Barrett Ramsey - Show gossip option if player has Call of the Crusade (25 player)'),
(15, 10704, 0, 0, 0, 19, 0, 8, 0, 0, 0, 0, 0, '', 'Barrett Ramsey - Show gossip option if in 25 player heroic'),
(15, 10704, 0, 0, 1, 13, 0, 0, 2, 2, 1, 0, 0, '', 'Barrett Ramsey - Show gossip option if Northrend Beasts were not failed'),
(15, 10704, 0, 0, 1, 17, 0, 3917, 0, 0, 0, 0, 0, '', 'Barrett Ramsey - Show gossip option if player has Call of the Crusade (10 player)'),
(15, 10704, 0, 0, 1, 19, 0, 4, 0, 0, 0, 0, 0, '', 'Barrett Ramsey - Show gossip option if in 10 player heroic'),
(15, 10704, 1, 0, 0, 13, 0, 0, 2, 2, 1, 0, 0, '', 'Barrett Ramsey - Show gossip option if Northrend Beasts were not failed'),
(15, 10704, 1, 0, 0, 17, 0, 3916, 0, 0, 1, 0, 0, '', 'Barrett Ramsey - Show gossip option if player lacks Call of the Crusade (25 player)'),
(15, 10704, 1, 0, 0, 19, 0, 8, 0, 0, 0, 0, 0, '', 'Barrett Ramsey - Show gossip option if in 25 player heroic'),
(15, 10704, 1, 0, 1, 13, 0, 0, 2, 2, 1, 0, 0, '', 'Barrett Ramsey - Show gossip option if Northrend Beasts were not failed'),
(15, 10704, 1, 0, 1, 17, 0, 3917, 0, 0, 1, 0, 0, '', 'Barrett Ramsey - Show gossip option if player lacks Call of the Crusade (10 player)'),
(15, 10704, 1, 0, 1, 19, 0, 4, 0, 0, 0, 0, 0, '', 'Barrett Ramsey - Show gossip option if in 10 player heroic'),
(15, 10704, 2, 0, 0, 13, 0, 0, 2, 2, 0, 0, 0, '', 'Barrett Ramsey - Show gossip option if Northrend Beasts were failed');

DELETE FROM `npc_text` WHERE (`ID` BETWEEN 724001 AND 724005);
DELETE FROM `npc_text_locale` WHERE (`ID` BETWEEN 724001 AND 724005);
