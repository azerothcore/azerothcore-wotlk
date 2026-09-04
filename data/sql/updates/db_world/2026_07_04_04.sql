-- DB update 2026_07_04_03 -> 2026_07_04_04
--
-- Flame Leviathan: Remove spell_linked_spell entries for SPELL_SYSTEMS_SHUTDOWN (62475).
-- These effects are now handled explicitly via script
DELETE FROM `spell_linked_spell` WHERE `spell_trigger` = -62475;

-- 62399 Overload Circuit: Entry 33139 (cannon), Entry 33113 (boss)
UPDATE `conditions` SET `SourceGroup` = 1, `Comment` = 'target must be Flame Leviathan' WHERE (`SourceTypeOrReferenceId` = 13) AND (`SourceGroup` = 3) AND (`SourceEntry` = 62399) AND (`SourceId` = 0) AND (`ElseGroup` = 0) AND (`ConditionTypeOrReference` = 31) AND (`ConditionTarget` = 0) AND (`ConditionValue1` = 3) AND (`ConditionValue2` = 33113) AND (`ConditionValue3` = 0);

-- change turret (33142) summontype from CORPSE_TIMED_DESPAWN (6) to CORPSE_DESPAWN (5) so InstallAccessory skips SetDeathState
UPDATE `vehicle_template_accessory` SET `summontype` = 5 WHERE `entry` = 33114 AND `accessory_entry` = 33142;
DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId` = 13) AND (`SourceGroup` = 2) AND (`SourceEntry` = 62399) AND (`SourceId` = 0) AND (`ElseGroup` = 0) AND (`ConditionTypeOrReference` = 31) AND (`ConditionTarget` = 0) AND (`ConditionValue1` = 3) AND (`ConditionValue2` = 33139) AND (`ConditionValue3` = 0);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(13, 2, 62399, 0, 0, 31, 0, 3, 33139, 0, 0, 0, 0, '', 'target must be Flame Leviathan');

-- ID - 62323 Hookshot
DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId` = 13) AND (`SourceGroup` = 1) AND (`SourceEntry` = 62323) AND (`SourceId` = 0) AND (`ElseGroup` = 0) AND (`ConditionTypeOrReference` = 31) AND (`ConditionTarget` = 0) AND (`ConditionValue1` = 3) AND (`ConditionValue2` = 33114) AND (`ConditionValue3` = 0);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(13, 1, 62323, 0, 0, 31, 0, 3, 33114, 0, 0, 0, 0, '', 'must be Flame Leviathan Seat');

-- Add missing text
DELETE FROM `creature_text` WHERE (`CreatureID` = 33113) AND (`GroupID` IN (20));
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(33113, 20, 0, 'The Flame Leviathan begins to overload!', 41, 0, 100, 0, 0, 0, 33276, 0, 'Flame Leviathan EMOTE_OVERLOAD_START');

DELETE FROM `spell_script_names` WHERE `spell_id` = 62336;
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(62336, 'spell_hookshot_aura');

DELETE FROM `spell_script_names` WHERE `ScriptName` = 'spell_vehicle_circuit_overload_aura';
