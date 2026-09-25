-- DB update 2026_08_15_00 -> 2026_08_15_01
-- Lines were misplaced
DELETE FROM `creature_text` WHERE (`CreatureID` = 28006);
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(28006, 0, 0, 'You think you\'ve won, mortal? Face the unbridled power of Antiok!', 14, 0, 100, 5, 0, 0, 27415, 0, 'Antiok - Dismount 1'),
(28006, 1, 0, 'Behold! The Scythe of Antiok!', 14, 0, 100, 397, 0, 0, 27416, 0, 'Antiok - Dismount 2'),
(28006, 2, 0, 'Soon, the bones of Galakrond will rise from their eternal slumber and wreak havoc upon this world!', 14, 0, 100, 0, 0, 0, 27406, 0, 'Antiok - OOC Yell'),
(28006, 2, 1, 'The Lich King demands more frost wyrms be sent to Angrathar! Meet his demands or face my wrath!', 14, 0, 100, 0, 0, 0, 27408, 0, 'Antiok - OOC Yell'),
(28006, 2, 2, 'Faster, dogs! We mustn\'t relent in our assault against the interlopers!', 14, 0, 100, 0, 0, 0, 27405, 0, 'Antiok - OOC Yell'),
(28006, 2, 3, 'Attackers are upon us! Let none through to this ancient grave!', 14, 0, 100, 0, 0, 0, 27409, 0, 'Antiok - OOC Yell'),
(28006, 2, 4, 'Hear me, minions! Hear your lord, Antiok! Double your efforts or pay the consequences of failure!', 14, 0, 100, 0, 0, 0, 27407, 0, 'Antiok - OOC Yell'),
(28006, 3, 0, 'The Scythe of Antiok drops to the ground!', 41, 0, 100, 0, 0, 0, 27410, 0, 'Antiok - On Death');

-- Set to Passive and Unset
DELETE FROM `smart_scripts` WHERE (`source_type` = 9 AND `entryorguid` = 2800600);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2800600, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Grand Necrolord Antiok - Actionlist - Set Reactstate Passive'),
(2800600, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Grand Necrolord Antiok - Actionlist - Say Line 0'),
(2800600, 9, 2, 0, 0, 0, 100, 0, 5000, 5000, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Grand Necrolord Antiok - Actionlist - Say Line 1'),
(2800600, 9, 3, 0, 0, 0, 100, 0, 5000, 5000, 0, 0, 0, 0, 11, 50501, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Grand Necrolord Antiok - Actionlist - Cast \'Flesh Harvest\''),
(2800600, 9, 4, 0, 0, 0, 100, 0, 3000, 3000, 0, 0, 0, 0, 28, 50494, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Grand Necrolord Antiok - Actionlist - Remove Aura \'Shroud of Lightning\''),
(2800600, 9, 5, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 19, 4, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Grand Necrolord Antiok - Actionlist - Remove Flags Disable Movement'),
(2800600, 9, 6, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 8, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Grand Necrolord Antiok - Actionlist - Set Reactstate Aggressive'),
(2800600, 9, 7, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 49, 0, 0, 0, 0, 0, 0, 21, 30, 0, 0, 0, 0, 0, 0, 0, 'Grand Necrolord Antiok - Actionlist - Start Attacking');

-- Just added the last two rows here
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 28006);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(28006, 0, 0, 0, 0, 0, 100, 0, 7000, 7000, 18000, 18000, 0, 0, 11, 32863, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Grand Necrolord Antiok - In Combat - Cast \'Seed of Corruption\''),
(28006, 0, 1, 0, 0, 0, 100, 0, 1100, 1100, 2000, 3000, 0, 0, 11, 50455, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Grand Necrolord Antiok - In Combat - Cast \'Shadow Bolt\''),
(28006, 0, 2, 0, 1, 0, 100, 0, 10000, 10000, 40000, 40000, 0, 0, 1, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Grand Necrolord Antiok - Out of Combat - Say Line 2'),
(28006, 0, 3, 0, 2, 0, 100, 1, 0, 25, 0, 0, 0, 0, 11, 50497, 1, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Grand Necrolord Antiok - Between 0-25% Health - Cast \'Scream of Chaos\' (No Repeat)'),
(28006, 0, 4, 0, 6, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 50472, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Grand Necrolord Antiok - On Just Died - Cast \'Drop Scythe of Antiok\''),
(28006, 0, 5, 0, 25, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 50494, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Grand Necrolord Antiok - On Reset - Cast \'Shroud of Lightning\''),
(28006, 0, 6, 0, 38, 0, 100, 512, 1, 0, 0, 0, 0, 0, 80, 2800600, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Grand Necrolord Antiok - On Data Set 1 0 - Run Script'),
(28006, 0, 7, 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 117, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Grand Necrolord Antiok - On Respawn - Disable Evade'),
(28006, 0, 8, 0, 6, 0, 100, 0, 0, 0, 0, 0, 0, 0, 1, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Grand Necrolord Antiok - On Just Died - Say Line 3');

-- Remove DISABLE_MOVE
UPDATE `creature_template` SET `unit_flags` = `unit_flags`&~4 WHERE (`entry` = 28006);

-- Missing implicit target
DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId` = 13) AND (`SourceGroup` = 3) AND (`SourceEntry` = 50501) AND (`SourceId` = 0) AND (`ElseGroup` = 0) AND (`ConditionTypeOrReference` = 31) AND (`ConditionTarget` = 0) AND (`ConditionValue1` = 3) AND (`ConditionValue2` = 27996) AND (`ConditionValue3` = 0);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(13, 3, 50501, 0, 0, 31, 0, 3, 27996, 0, 0, 0, 0, '', 'Antiok\'s Flesh Harvest only targets Wyrmrest Vanquisher');

-- Let the item spell use spell_area rather than conditions
DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId` = 17) AND (`SourceEntry` = 50426) AND (`ConditionTypeOrReference` = 23);
DELETE FROM `spell_area` WHERE `spell` = 50426 AND `area` = 4174 AND `quest_start` = 0 AND `aura_spell` = 0 AND `racemask` = 0 AND `gender` = 2;
INSERT INTO `spell_area` (`spell`, `area`, `quest_start`, `quest_end`, `aura_spell`, `racemask`, `gender`, `autocast`, `quest_start_status`, `quest_end_status`) VALUES
(50426, 4174, 0, 0, 0, 0, 2, 0, 64, 11);

-- If you're gonna boast about your scythe might as well be holding it, no?
UPDATE `creature_template_addon` SET `bytes2` = 1 WHERE (`entry` = 28006);
