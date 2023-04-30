-- DB update 2023_04_19_14 -> 2023_04_19_15
-- 22199 (Slaag)
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 22199);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(22199, 0, 0, 1, 0, 0, 100, 0, 20000, 30000, 20000, 30000, 0, 11, 33958, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Slaag - In Combat - Cast \'Enrage\''),
(22199, 0, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Slaag - In Combat - Say Line 0'),
(22199, 0, 2, 0, 0, 0, 100, 0, 27000, 32000, 27000, 32000, 0, 11, 21909, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Slaag - In Combat - Cast \'Dust Field\''),
(22199, 0, 3, 0, 6, 0, 100, 512, 0, 0, 0, 0, 0, 11, 39898, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Slaag - On Just Died - Cast \'Slaag: Summon Slaag`s Standard Chest\'');

-- 20600 (Maggoc)
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 20600);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(20600, 0, 0, 0, 0, 0, 100, 0, 3000, 6000, 8000, 12000, 0, 11, 38770, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Maggoc - In Combat - Cast \'Mortal Wound\''),
(20600, 0, 1, 0, 0, 0, 100, 0, 3000, 6000, 5000, 10000, 0, 11, 38777, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 0, 'Maggoc - In Combat - Cast \'Rock Rumble\''),
(20600, 0, 2, 0, 0, 0, 100, 0, 4000, 7000, 5000, 10000, 0, 11, 42139, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 0, 'Maggoc - In Combat - Cast \'Boulder\''),
(20600, 0, 3, 4, 2, 0, 100, 0, 0, 30, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Maggoc - Between 0-30% Health - Say Line 0'),
(20600, 0, 4, 0, 61, 0, 100, 512, 0, 0, 0, 0, 0, 11, 40743, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Maggoc - Between 0-30% Health - Cast \'Frenzy\''),
(20600, 0, 5, 0, 6, 0, 100, 512, 0, 0, 0, 0, 0, 11, 39891, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Maggoc - On Just Died - Cast \'Maggoc: Summon Maggoc`s Treasure Chest\'');

-- 20216 (Grulloc)
DELETE FROM `creature_text` WHERE `CreatureID`=20216;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(20216, 0, 0, '%s grows massively powerful!', 16, 0, 100, 0, 0, 0, 20101, 0, 'Grulloc'),
(20216, 1, 0, 'Grulloc having lots of fun!', 14, 0, 100, 0, 0, 0, 19841, 0, 'Grulloc'),
(20216, 2, 0, 'Me hungry!', 14, 0, 100, 0, 0, 0, 19842, 0, 'Grulloc'),
(20216, 3, 0, 'Me keep piggy as pet!', 14, 0, 100, 0, 0, 0, 20259, 0, 'Grulloc'),
(20216, 4, 0, 'Me like soft bacon!', 14, 0, 100, 0, 0, 0, 20258, 0, 'Grulloc'),
(20216, 5, 0, 'Mmm, other white meat!', 14, 0, 100, 0, 0, 0, 19844, 0, 'Grulloc'),
(20216, 6, 0, 'Piggy stop!', 14, 0, 100, 0, 0, 0, 19845, 0, 'Grulloc'),
(20216, 7, 0, 'Porkchops!', 14, 0, 100, 0, 0, 0, 19857, 0, 'Grulloc'),
(20216, 8, 0, 'Where piggy go?!', 14, 0, 100, 0, 0, 0, 19846, 0, 'Grulloc'),
(20216, 9, 0, 'You be Grulloc\'s friend!', 14, 0, 100, 0, 0, 0, 19843, 0, 'Grulloc');

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 20216);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(20216, 0, 0, 1, 0, 0, 100, 0, 10000, 20000, 18000, 28000, 0, 11, 38771, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Grulloc - In Combat - Cast \'Burning Rage\''),
(20216, 0, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Grulloc - In Combat - Say Line 0'),
(20216, 0, 2, 0, 0, 0, 100, 0, 5000, 9000, 12000, 17000, 0, 11, 21055, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Grulloc - In Combat - Cast \'Crush Armor\''),
(20216, 0, 3, 0, 0, 0, 100, 0, 6000, 17000, 5000, 10000, 0, 11, 38772, 32, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 0, 'Grulloc - In Combat - Cast \'Grievous Wound\''),
(20216, 0, 4, 0, 6, 0, 100, 512, 0, 0, 0, 0, 0, 11, 39890, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Grulloc - On Just Died - Cast \'Grulloc: Summon Grulloc`s Dragon Skull Chest\''),
(20216, 0, 5, 0, 8, 0, 100, 0, 38360, 0, 0, 0, 0, 49, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Grulloc - On Spellhit \'Huffer Threatens Grulloc\' - Start Attacking');
