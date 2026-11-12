-- DB update 2026_10_16_03 -> 2026_10_16_04
--
DELETE FROM `creature_text` WHERE `CreatureID` = 20777 AND `GroupID` = 1;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(20777, 1, 0, '%s rushes to the aid of a nearby doe!', 16, 0, 100, 0, 0, 0, 18998, 0, 'Talbuk Sire');

DELETE FROM `smart_scripts` WHERE `entryorguid` = 20610 AND `source_type` = 0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(20610, 0, 0, 1, 25, 0, 100, 512, 0, 0, 0, 0, 0, 0, 19, 6, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Talbuk Doe - On Reset - Remove Unit Flags'),
(20610, 0, 1, 0, 61, 0, 100, 512, 0, 0, 0, 0, 0, 0, 91, 7, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Talbuk Doe - On Reset - Remove Bytes0'),
(20610, 0, 2, 0, 0, 0, 100, 0, 2000, 6000, 15000, 22000, 0, 0, 11, 32019, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Talbuk Doe - In Combat - Cast Gore'),
(20610, 0, 3, 0, 2, 0, 100, 1, 0, 20, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Talbuk Doe - Between Health 0-20% - Say Line 1'),
(20610, 0, 4, 5, 8, 0, 100, 512, 35771, 0, 0, 0, 0, 0, 33, 20982, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Talbuk Doe - On Spell Hit - Kill Credit'),
(20610, 0, 5, 6, 61, 0, 100, 512, 0, 0, 0, 0, 0, 0, 11, 42386, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Talbuk Doe - On Spell Hit - Cast Sleeping Sleep'),
(20610, 0, 6, 7, 61, 0, 100, 512, 0, 0, 0, 0, 0, 0, 41, 10000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Talbuk Doe - On Spell Hit - Despawn'),
(20610, 0, 7, 8, 61, 0, 100, 512, 0, 0, 0, 0, 0, 0, 18, 6, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Talbuk Doe - On Spell Hit - Set Unit Flags'),
(20610, 0, 8, 0, 61, 0, 100, 512, 0, 0, 0, 0, 0, 0, 90, 7, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Talbuk Doe - On Spell Hit - Set Bytes0'),
(20610, 0, 9, 10, 4, 0, 100, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Talbuk Doe - On Aggro - Say Line 0'),
(20610, 0, 10, 11, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 64, 1, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Talbuk Doe - On Aggro - Store Targetlist'),
(20610, 0, 11, 12, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 100, 1, 0, 0, 0, 0, 0, 9, 20777, 0, 35, 1, 0, 0, 0, 0, 'Talbuk Doe - On Aggro - Send Target 1 (Talbuk Sire)'),
(20610, 0, 12, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 223, 1, 0, 0, 0, 0, 0, 9, 20777, 0, 35, 1, 0, 0, 0, 0, 'Talbuk Doe - On Aggro - Do Action ID 1 (Talbuk Sire)');

DELETE FROM `smart_scripts` WHERE `entryorguid` = 20777 AND `source_type` = 0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(20777, 0, 0, 1, 25, 0, 100, 512, 0, 0, 0, 0, 0, 0, 19, 6, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Talbuk Sire - On Reset - Remove Unit Flags'),
(20777, 0, 1, 0, 61, 0, 100, 512, 0, 0, 0, 0, 0, 0, 91, 7, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Talbuk Sire - On Reset - Remove Bytes0'),
(20777, 0, 2, 0, 0, 0, 100, 0, 2000, 9000, 12000, 17000, 0, 0, 11, 32023, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Talbuk Sire - In Combat - Cast Hoof Stomp'),
(20777, 0, 3, 0, 2, 0, 100, 1, 0, 20, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Talbuk Sire - Between Health 0-20% - Say Line 0'),
(20777, 0, 4, 5, 8, 0, 100, 512, 35771, 0, 0, 0, 0, 0, 33, 20982, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Talbuk Sire - On Spell Hit - Kill Credit'),
(20777, 0, 5, 6, 61, 0, 100, 512, 0, 0, 0, 0, 0, 0, 11, 42386, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Talbuk Sire - On Spell Hit - Cast Sleeping Sleep'),
(20777, 0, 6, 7, 61, 0, 100, 512, 0, 0, 0, 0, 0, 0, 41, 10000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Talbuk Sire - On Spell Hit - Despawn'),
(20777, 0, 7, 8, 61, 0, 100, 512, 0, 0, 0, 0, 0, 0, 18, 6, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Talbuk Sire - On Spell Hit - Set Unit Flags'),
(20777, 0, 8, 0, 61, 0, 100, 512, 0, 0, 0, 0, 0, 0, 90, 7, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Talbuk Sire - On Spell Hit - Set Bytes0'),
(20777, 0, 9, 10, 72, 0, 100, 0, 1, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Talbuk Sire - On Action 1 Done - Say Line 1'),
(20777, 0, 10, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 49, 0, 0, 0, 0, 0, 0, 12, 1, 0, 0, 0, 0, 0, 0, 0, 'Talbuk Sire - On Action 1 Done - Start Attack Stored Target 1');
