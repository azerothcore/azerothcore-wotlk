-- DB update 2023_01_04_00 -> 2023_01_04_01
-- Fix Positions
UPDATE `creature` SET `position_x`=1735.767578125, `position_y`=1072.0616455078125, `position_z`=6.96295166015625, `orientation`=3.246312379837036132, `VerifiedBuild`=47187 WHERE `id1`=20342;
UPDATE `creature` SET `position_x`=1735.560546875, `position_y`=1074.1854248046875, `position_z`=6.96295166015625, `orientation`=3.193952560424804687, `VerifiedBuild`=47187 WHERE `id1`=20342;

-- Fix EmoteState
DELETE FROM `creature_template_addon` WHERE (`entry` IN (20342, 20344));
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `visibilityDistanceType`, `auras`) VALUES
(20342, 0, 0, 0, 1, 379, 0, ''),
(20344, 0, 0, 0, 1, 379, 0, '');

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 20344);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(20344, 0, 0, 0, 25, 0, 100, 0, 0, 0, 0, 0, 0, 22, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Nat Pagle - On Reset - Set Event Phase 1'),
(20344, 0, 1, 0, 60, 1, 100, 0, 120000, 120000, 120000, 120000, 0, 80, 2034400, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Nat Pagle - On Update - Run Script (Phase 1)'),
(20344, 0, 2, 0, 60, 2, 100, 0, 2800, 2800, 2800, 2800, 0, 80, 2034401, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Nat Pagle - On Update - Run Script (Phase 2)'),
(20344, 0, 3, 0, 60, 4, 100, 0, 2800, 2800, 2800, 2800, 0, 80, 2034402, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Nat Pagle - On Update - Run Script (Phase 3)'),
(20344, 0, 4, 0, 60, 8, 100, 0, 2800, 2800, 2800, 2800, 0, 80, 2034403, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Nat Pagle - On Update - Run Script (Phase 4)'),
(20344, 0, 5, 0, 60, 16, 100, 0, 2800, 2800, 2800, 2800, 0, 80, 2034404, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Nat Pagle - On Update - Run Script (Phase 5)'),
(20344, 0, 6, 0, 60, 32, 100, 0, 2800, 2800, 2800, 2800, 0, 80, 2034405, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Nat Pagle - On Update - Run Script (Phase 6)'),
(20344, 0, 7, 0, 60, 64, 100, 0, 2800, 2800, 2800, 2800, 0, 80, 2034406, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Nat Pagle - On Update - Run Script (Phase 7)'),
(20344, 0, 8, 0, 60, 128, 100, 0, 2800, 2800, 2800, 2800, 0, 80, 2034407, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Nat Pagle - On Update - Run Script (Phase 8)');

DELETE FROM `smart_scripts` WHERE ((`entryorguid` BETWEEN 2034400 AND 2034407) AND (`source_type` = 9));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2034400, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Nat Pagle - On Script - Say Line \'Hal...\''),
(2034400, 9, 1, 0, 0, 0, 100, 0, 2500, 2500, 0, 0, 0, 45, 1, 1, 0, 0, 0, 0, 19, 20342, 10, 0, 0, 0, 0, 0, 0, 'Nat Pagle - On Script - Trigger Hal \'Yea, Nat?\''),
(2034400, 9, 2, 0, 0, 0, 100, 0, 2000, 2000, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Nat Pagle - On Script - Say Line \'Had that dream again last night...\''),
(2034400, 9, 3, 0, 0, 0, 100, 0, 5500, 5500, 0, 0, 0, 45, 1, 2, 0, 0, 0, 0, 19, 20342, 10, 0, 0, 0, 0, 0, 0, 'Nat Pagle - On Script - Trigger Hal \'Which one?\''),
(2034400, 9, 4, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 31, 2, 8, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Nat Pagle - On Script - Set Phase Random Between 2-8'),

(2034401, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 22, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Nat Pagle - On Script - Restore Event Phase 1'),
(2034401, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 1, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Nat Pagle - On Script - Say Part 1'),
(2034401, 9, 2, 0, 0, 0, 100, 0, 6000, 6000, 0, 0, 0, 1, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Nat Pagle - On Script - Say Part 2'),
(2034401, 9, 3, 0, 0, 0, 100, 0, 6000, 6000, 0, 0, 0, 1, 4, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Nat Pagle - On Script - Say Part 3'),
(2034401, 9, 4, 0, 0, 0, 100, 0, 8500, 8500, 0, 0, 0, 45, 1, 3, 0, 0, 0, 0, 19, 20342, 10, 0, 0, 0, 0, 0, 0, 'Nat Pagle - On Script - Trigger Closing Line'),

(2034402, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 22, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Nat Pagle - On Script - Restore Event Phase 1'),
(2034402, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 1, 5, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Nat Pagle - On Script - Say Part 1'),
(2034402, 9, 2, 0, 0, 0, 100, 0, 6000, 6000, 0, 0, 0, 1, 6, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Nat Pagle - On Script - Say Part 2'),
(2034402, 9, 3, 0, 0, 0, 100, 0, 6000, 6000, 0, 0, 0, 1, 7, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Nat Pagle - On Script - Say Part 3'),
(2034402, 9, 4, 0, 0, 0, 100, 0, 8500, 8500, 0, 0, 0, 45, 1, 3, 0, 0, 0, 0, 19, 20342, 10, 0, 0, 0, 0, 0, 0, 'Nat Pagle - On Script - Trigger Closing Line'),

(2034403, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 22, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Nat Pagle - On Script - Restore Event Phase 1'),
(2034403, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 1, 8 , 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Nat Pagle - On Script - Say Part 1'),
(2034403, 9, 2, 0, 0, 0, 100, 0, 6000, 6000, 0, 0, 0, 1, 9 , 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Nat Pagle - On Script - Say Part 2'),
(2034403, 9, 3, 0, 0, 0, 100, 0, 6000, 6000, 0, 0, 0, 1, 10, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Nat Pagle - On Script - Say Part 3'),
(2034403, 9, 4, 0, 0, 0, 100, 0, 8500, 8500, 0, 0, 0, 45, 1, 3, 0, 0, 0, 0, 19, 20342, 10, 0, 0, 0, 0, 0, 0, 'Nat Pagle - On Script - Trigger Closing Line'),

(2034404, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 22, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Nat Pagle - On Script - Restore Event Phase 1'),
(2034404, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 1, 11, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Nat Pagle - On Script - Say Part 1'),
(2034404, 9, 2, 0, 0, 0, 100, 0, 6000, 6000, 0, 0, 0, 1, 12, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Nat Pagle - On Script - Say Part 2'),
(2034404, 9, 3, 0, 0, 0, 100, 0, 6000, 6000, 0, 0, 0, 1, 13, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Nat Pagle - On Script - Say Part 3'),
(2034404, 9, 4, 0, 0, 0, 100, 0, 8500, 8500, 0, 0, 0, 45, 1, 3, 0, 0, 0, 0, 19, 20342, 10, 0, 0, 0, 0, 0, 0, 'Nat Pagle - On Script - Trigger Closing Line'),

(2034405, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 22, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Nat Pagle - On Script - Restore Event Phase 1'),
(2034405, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 1, 14, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Nat Pagle - On Script - Say Part 1'),
(2034405, 9, 2, 0, 0, 0, 100, 0, 6000, 6000, 0, 0, 0, 1, 15, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Nat Pagle - On Script - Say Part 2'),
(2034405, 9, 3, 0, 0, 0, 100, 0, 6000, 6000, 0, 0, 0, 1, 16, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Nat Pagle - On Script - Say Part 3'),
(2034405, 9, 4, 0, 0, 0, 100, 0, 8500, 8500, 0, 0, 0, 45, 1, 3, 0, 0, 0, 0, 19, 20342, 10, 0, 0, 0, 0, 0, 0, 'Nat Pagle - On Script - Trigger Closing Line'),

(2034406, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 22, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Nat Pagle - On Script - Restore Event Phase 1'),
(2034406, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 1, 17, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Nat Pagle - On Script - Say Part 1'),
(2034406, 9, 2, 0, 0, 0, 100, 0, 6000, 6000, 0, 0, 0, 1, 18, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Nat Pagle - On Script - Say Part 2'),
(2034406, 9, 3, 0, 0, 0, 100, 0, 6000, 6000, 0, 0, 0, 1, 19, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Nat Pagle - On Script - Say Part 3'),
(2034406, 9, 4, 0, 0, 0, 100, 0, 8500, 8500, 0, 0, 0, 45, 1, 3, 0, 0, 0, 0, 19, 20342, 10, 0, 0, 0, 0, 0, 0, 'Nat Pagle - On Script - Trigger Closing Line'),

(2034407, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 22, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Nat Pagle - On Script - Restore Event Phase 1'),
(2034407, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 1, 20, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Nat Pagle - On Script - Say Part 1'),
(2034407, 9, 2, 0, 0, 0, 100, 0, 6000, 6000, 0, 0, 0, 1, 21, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Nat Pagle - On Script - Say Part 2'),
(2034407, 9, 3, 0, 0, 0, 100, 0, 6000, 6000, 0, 0, 0, 1, 22, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Nat Pagle - On Script - Say Part 3'),
(2034407, 9, 4, 0, 0, 0, 100, 0, 8500, 8500, 0, 0, 0, 45, 1, 3, 0, 0, 0, 0, 19, 20342, 10, 0, 0, 0, 0, 0, 0, 'Nat Pagle - On Script - Trigger Closing Line');

DELETE FROM `creature_text` WHERE `CreatureID`=20344;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `BroadcastTextId`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `TextRange`, `comment`) VALUES
(20344, 0 , 0, 17966, 'Hal...', 12, 0, 100, 0, 0, 0, 0, 'Nat Pagle'),

(20344, 1 , 0, 17968, 'Had that dream again last night...', 12, 0, 100, 0, 0, 0, 0, 'Nat Pagle'),

(20344, 2 , 0, 17970, 'That one dream... The crazy one. Remember?', 12, 0, 100, 0, 0, 0, 0, 'Nat Pagle'),
(20344, 3 , 0, 17971, 'Tarren Mill is destroyed by some crazy force of undead and forever more becomes an enemy to Southshore.', 12, 0, 100, 0, 0, 0, 0, 'Nat Pagle'),
(20344, 4 , 0, 17972, 'Could ya imagine such a thing, Hal? Could ya?', 12, 0, 100, 0, 0, 0, 0, 'Nat Pagle'),

(20344, 5 , 0, 17973, 'That one where I\'m in Durnholde and that one orc that Blackmoore keeps as his personal slave breaks out...', 12, 0, 100, 0, 0, 0, 0, 'Nat Pagle'),
(20344, 6 , 0, 17974, 'He ends up destroying the whole keep, freeing all the orcs we\'re keeping in the camps, and rising to power as the king of orcs... Warchief or somethin\'.', 12, 0, 100, 0, 0, 0, 0, 'Nat Pagle'),
(20344, 7 , 0, 17975, 'Crazy, isn\'t it?', 12, 0, 100, 0, 0, 0, 0, 'Nat Pagle'),

(20344, 8 , 0, 17976, 'So I\'m on some mountain with some big ol\' tree. Bunch of elves runnin\' around all over...', 12, 0, 100, 0, 0, 0, 0, 'Nat Pagle'),
(20344, 9 , 0, 17977, 'Out of nowhere, some 300 foot tall demon or somethin\' walks up and starts climbin\' the tree...', 12, 0, 100, 0, 0, 0, 0, 'Nat Pagle'),
(20344, 10, 0, 17978, 'And if that weren\'t crazy enough, that big demon gets killed by a bunch of little floating light things... Oh, I was also a female elf in that one... Yep...', 12, 0, 100, 0, 0, 0, 0, 'Nat Pagle'),

(20344, 11, 0, 17979, 'In this dream, I was fishin\' master of the world. I moved to some place called Kalimdor...', 12, 0, 100, 0, 0, 0, 0, 'Nat Pagle'),
(20344, 12, 0, 17980, 'And people from all over the world come to me to pay homage... and learn to fish.', 12, 0, 100, 0, 0, 0, 0, 'Nat Pagle'),
(20344, 13, 0, 17981, 'I\'m like some kind of fishing god...', 12, 0, 100, 0, 0, 0, 0, 'Nat Pagle'),

(20344, 14, 0, 17982, 'I can\'t even believe this one... You know those two loud-mouthed ruffians, Foror and Tigule?', 12, 0, 100, 0, 0, 0, 0, 'Nat Pagle'),
(20344, 15, 0, 17983, 'Well in this dream, they somehow end up inventing something called ice-cream and flavoring it with strawberries... Well, long story short, they end up striking it rich!', 12, 0, 100, 0, 0, 0, 0, 'Nat Pagle'),
(20344, 16, 0, 17984, 'If that weren\'t crazy enough, they decide to quit the ice-cream business and become adventurers... They travel all over the place and finally disappear into some portal. I woke up in a cold sweat after that one...', 12, 0, 100, 0, 0, 0, 0, 'Nat Pagle'),

(20344, 17, 0, 17985, 'This one\'s real grim... So the king\'s kid, Arthas... Well he goes out to battle evil, along with Uther... *Nat pats his brow dry*', 12, 0, 100, 0, 0, 0, 0, 'Nat Pagle'),
(20344, 18, 0, 17986, 'But tragically, Arthas is consumed by the evil and becomes evil himself...', 12, 0, 100, 0, 0, 0, 0, 'Nat Pagle'),
(20344, 19, 0, 17987, 'Well, he comes back to the king all pretendin\' to be nice, draws his sword, and runs the king through, elbow to ... well you know... kills him on the spot.', 12, 0, 100, 0, 0, 0, 0, 'Nat Pagle'),

(20344, 20, 0, 18060, 'That one where thousands of people are all watching us from up in the sky...', 12, 0, 100, 0, 0, 0, 0, 'Nat Pagle'),
(20344, 21, 0, 18061, 'We\'re like their puppets - we dance and cry and fight and say silly things for their amusement.\n', 12, 0, 100, 0, 0, 0, 0, 'Nat Pagle'),
(20344, 22, 0, 18062, 'Sometimes, even when I\'m awake, I think they\'re watching us. Maybe they\'re watching us right now...', 12, 0, 100, 0, 0, 0, 0, 'Nat Pagle');

DELETE FROM `creature_text` WHERE `CreatureID`=20342;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `BroadcastTextId`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `TextRange`, `comment`) VALUES
(20342, 0, 0, 17967, 'Yea, Nat?', 12, 0, 100, 0, 0, 0, 0, 'Hal McAllister'),

(20342, 1, 0, 17969, 'Which one?', 12, 0, 100, 0, 0, 0, 0, 'Hal McAllister'),

(20342, 2, 0, 17988, 'It\'ll never happen, Nat.\n', 12, 0, 100, 0, 0, 0, 0, 'Hal McAllister'),
(20342, 2, 1, 17989, 'Impossible!\n', 12, 0, 100, 0, 0, 0, 0, 'Hal McAllister'),
(20342, 2, 2, 17990, 'I worry about you sometimes, Nat.', 12, 0, 100, 0, 0, 0, 0, 'Hal McAllister'),
(20342, 2, 3, 17991, 'No way.\n', 12, 0, 100, 0, 0, 0, 0, 'Hal McAllister'),
(20342, 2, 4, 17992, 'Nat, I\'ve heard a whopper or two in my day but that one takes the cake.\n', 12, 0, 100, 0, 0, 0, 0, 'Hal McAllister'),
(20342, 2, 5, 17993, 'What you got in that pipe, Nat?\n', 12, 0, 100, 0, 0, 0, 0, 'Hal McAllister'),
(20342, 2, 6, 17994, '*Hal shakes his head* Nat, Nat, Nat...\n', 12, 0, 100, 0, 0, 0, 0, 'Hal McAllister'),
(20342, 2, 7, 17995, 'Shut up and fish, Nat.\n', 12, 0, 100, 0, 0, 0, 0, 'Hal McAllister');

DELETE FROM `smart_scripts` WHERE (`entryorguid` = 20342) AND (`source_type` = 0);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(20342, 0, 0, 0, 38, 0, 100, 0, 1, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Hal McAllister - On Data Set 1 1 - Say \'Yea, Nat?\''),
(20342, 0, 1, 0, 38, 0, 100, 0, 1, 2, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Hal McAllister - On Data Set 1 2 - Say \'Which one?\''),
(20342, 0, 2, 0, 38, 0, 100, 0, 1, 3, 0, 0, 0, 1, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Hal McAllister - On Data Set 1 3 - Say Closing Line');
