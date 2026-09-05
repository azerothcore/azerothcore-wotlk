-- ----------------------------------------------------------------------------
-- Dalaran (Northrend, map 571)
-- Dedication of Honor Behavior Implementation
-- Pre and post Lich King kill on the realm (Normal, Heroic, 10 & 25 players)
-- ----------------------------------------------------------------------------
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 30 AND `SourceGroup` = 1 AND `SourceEntry` = 202443 AND `SourceId` = 342;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(30, 1, 202443, 342, 0, 11, 0, 20009, 1, 0, 0, 0, 0, '', 'Dalaran - Dedication of Honor plaques visible after the realm defeats the Lich King');

-- Gossip on the plaques: show a gossip menu on use (gossipID 11431) instead of the plaque
-- page (pageId 3605). Menu 11431 has the single option "See the fall of the Lich King."
-- Both values confirmed against a retail sniff of Runeweaver Square (Data7 = 0, Data19 = 11431).
UPDATE `gameobject_template` SET `Data7` = 0, `Data19` = 11431 WHERE `entry` = 202443;

-- SmartAI is now the plaques (202443) only: gossip option select -> run script -> play the Fall
-- of the Lich King cinematic and close the gossip.
DELETE FROM `smart_scripts` WHERE `source_type` = 1 AND `entryorguid` = 202443;
DELETE FROM `smart_scripts` WHERE `source_type` = 9 AND `entryorguid` = 20244300;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(202443, 1, 0, 1, 62, 0, 100, 0, 11431, 0, 0, 0, 0, 0, 64, 1, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Dedication of Honor - On Gossip Option Select - Store Targetlist'),
(202443, 1, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 80, 20244300, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Dedication of Honor - On Link - Run Script'),
(20244300, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 72, 0, 0, 0, 0, 0, 0, 12, 1, 0, 0, 0, 0, 0, 0, 0, 'Dedication of Honor - On Script - Close Gossip'),
(20244300, 9, 1, 0, 0, 0, 100, 0, 1000, 1000, 0, 0, 0, 0, 68, 16, 0, 0, 0, 0, 0, 12, 1, 0, 0, 0, 0, 0, 0, 0, 'Dedication of Honor - On Script - Play Movie 16');

-- Remove the personal-achievement gate on the plaque gossip event
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 22 AND `SourceEntry` = 202443 AND `SourceId` = 1 AND `SourceGroup` = 1;

-- Clean up the realm-first gate that stock AzerothCore placed on the plaque's old behavior
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 22 AND `SourceEntry` = 202443 AND `SourceId` = 1 AND `SourceGroup` = 3;

-- Runeweaver Square Fountain (202616, 151164)
-- The fountain is NOT gated on visibility - it stays in the world so its GameObjectAI can
-- activate it. The old fountain-hide condition is removed here if it was previously applied.
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 30 AND `SourceGroup` = 1 AND `SourceEntry` = 202616 AND `SourceId` = 151164;

-- Bind the fountain to its C++ GameObjectAI and clear any SmartAI a previous revision set on it.
-- ScriptName go_dalaran_lich_king_monument (zone_dalaran.cpp) reveals the statue when 20009 = 1.
-- NOTE: ScriptName/AIName bind when the gameobject SPAWNS, so the already-spawned fountain only
-- picks this up after a respawn or worldserver restart (which a code change requires anyway).
UPDATE `gameobject_template` SET `AIName` = '', `ScriptName` = 'go_dalaran_lich_king_monument' WHERE `entry` = 202616;

-- Any SmartAI a previous revision placed on the fountain is removed - its reveal now lives in C++,
-- so no smart-event condition is needed here anymore.
DELETE FROM `smart_scripts` WHERE `source_type` = 1 AND `entryorguid` = 202616;
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 22 AND `SourceEntry` = 202616 AND `SourceId` = 1 AND `SourceGroup` = 1;
