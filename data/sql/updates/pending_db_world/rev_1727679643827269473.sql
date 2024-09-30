--
DELETE FROM `spell_script_names` WHERE `spell_id`=39953 AND `ScriptName`='spell_gen_adals_song_of_battle';
-- A'dal
UPDATE `smart_scripts` SET `link` = 5 WHERE (`entryorguid` = 18481) AND (`source_type` = 0) AND (`id` = 4);
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 18481) AND (`source_type` = 0) AND (`id` = 5);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(18481, 0, 5, 0, 61, 0, 100, 512, 0, 0, 0, 0, 0, 0, 238, 39953, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'A Dal - On Quest Reward 11007 - Run World State Script Event 39953');

-- Magtheridon's Head
UPDATE `gameobject_template` SET `ScriptName` = 'go_magtheridons_head' WHERE (`entry` = 184640);

-- Trollbane
UPDATE `smart_scripts` SET `link` = 4 WHERE (`entryorguid` = 16819) AND (`source_type` = 0) AND (`id` = 2);
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 16819) AND (`source_type` = 0) AND (`id` = 4);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(16819, 0, 4, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 50, 184640, 7200, 0, 0, 0, 0, 8, 0, 0, 0, 0, -732.28, 2670.99, 94.5875, -0.541051, 'Force Commander Danath Trollbane - On Quest \'The Fall of Magtheridon\' Finished - Summon Gameobject \'Magtheridon\'s Head\' Alliance');
DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId` = 22) AND (`SourceGroup` = 5) AND (`SourceEntry` = 16819);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(22, 5, 16819, 3, 0, 103, 0, 39911, 0, 0, 1, 0, 0, '', 'if Gameobject \'Magtheridon\'s Head\' Alliance is not already spawned');

-- Nazgrel
UPDATE `smart_scripts` SET `link` = 3 WHERE (`entryorguid` = 3230) AND (`source_type` = 0) AND (`id` = 1);
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 3230) AND (`source_type` = 0) AND (`id` = 3);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(3230, 0, 3, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 50, 184640, 7200, 0, 0, 0, 0, 8, 0, 0, 0, 0, 143.417, 2673.36, 85.3014, 3.01941, 'Nazgrel - On Quest \'The Fall of Magtheridon\' Finished - Summon Gameobject \'Magtheridon\'s Head\' Horde');
DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId` = 22) AND (`SourceGroup` = 4) AND (`SourceEntry` = 3230);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(22, 4, 3230, 3, 0, 103, 0, 39913, 0, 0, 1, 0, 0, '', 'if Gameobject \'Magtheridon\'s Head\' Horde is not already spawned');

-- Apply zone wide buff in these areas
DELETE FROM `spell_area` WHERE `spell` IN (39911, 39913, 39953);
INSERT INTO `spell_area` (`spell`, `area`, `quest_start`, `quest_end`, `aura_spell`, `racemask`, `gender`, `autocast`, `quest_start_status`, `quest_end_status`) VALUES
(39953, 3847, 0, 0, 0, 0, 2, 1, 74, 11), -- Botanica
(39953, 3848, 0, 0, 0, 0, 2, 1, 74, 11), -- Arcatraz
(39953, 3849, 0, 0, 0, 0, 2, 1, 74, 11), -- Mechanar
(39953, 3703, 0, 0, 0, 0, 2, 1, 74, 11), -- Shattrath
(39953, 3896, 0, 0, 0, 0, 2, 1, 74, 11), -- Aldor's Rise
(39953, 3898, 0, 0, 0, 0, 2, 1, 74, 11), -- Scryer's Tier
(39953, 3899, 0, 0, 0, 0, 2, 1, 74, 11), -- Lower City
(39911, 3562, 0, 0, 0, 1101, 2, 1, 74, 11), -- Ramparts (Alliance)
(39911, 3713, 0, 0, 0, 1101, 2, 1, 74, 11), -- The Blood Furnace (Alliance)
(39911, 3714, 0, 0, 0, 1101, 2, 1, 74, 11), -- The Shattered Halls (Alliance)
(39911, 3836, 0, 0, 0, 1101, 2, 1, 74, 11), -- Magtheridon's Lair (Alliance)
(39913, 3562, 0, 0, 0, 690, 2, 1, 74, 11),  -- Ramparts (Horde)
(39913, 3713, 0, 0, 0, 690, 2, 1, 74, 11),  -- The Blood Furnace (Horde)
(39913, 3714, 0, 0, 0, 690, 2, 1, 74, 11),  -- The Shattered Halls (Horde)
(39913, 3836, 0, 0, 0, 690, 2, 1, 74, 11),  -- Magtheridon's Lair (Horde)
-- Hellfire Peninsula (Alliance)
(39911, 3483, 0, 0, 0, 1101, 2, 1, 74, 11),
(39911, 3536, 0, 0, 0, 1101, 2, 1, 74, 11),
(39911, 3538, 0, 0, 0, 1101, 2, 1, 74, 11),
(39911, 3539, 0, 0, 0, 1101, 2, 1, 74, 11),
(39911, 3541, 0, 0, 0, 1101, 2, 1, 74, 11),
(39911, 3542, 0, 0, 0, 1101, 2, 1, 74, 11),
(39911, 3543, 0, 0, 0, 1101, 2, 1, 74, 11),
(39911, 3544, 0, 0, 0, 1101, 2, 1, 74, 11),
(39911, 3545, 0, 0, 0, 1101, 2, 1, 74, 11),
(39911, 3546, 0, 0, 0, 1101, 2, 1, 74, 11),
(39911, 3547, 0, 0, 0, 1101, 2, 1, 74, 11),
(39911, 3548, 0, 0, 0, 1101, 2, 1, 74, 11),
(39911, 3549, 0, 0, 0, 1101, 2, 1, 74, 11),
(39911, 3550, 0, 0, 0, 1101, 2, 1, 74, 11),
(39911, 3551, 0, 0, 0, 1101, 2, 1, 74, 11),
(39911, 3552, 0, 0, 0, 1101, 2, 1, 74, 11),
(39911, 3553, 0, 0, 0, 1101, 2, 1, 74, 11),
(39911, 3554, 0, 0, 0, 1101, 2, 1, 74, 11),
(39911, 3555, 0, 0, 0, 1101, 2, 1, 74, 11),
(39911, 3556, 0, 0, 0, 1101, 2, 1, 74, 11),
(39911, 3582, 0, 0, 0, 1101, 2, 1, 74, 11),
(39911, 3669, 0, 0, 0, 1101, 2, 1, 74, 11),
(39911, 3670, 0, 0, 0, 1101, 2, 1, 74, 11),
(39911, 3671, 0, 0, 0, 1101, 2, 1, 74, 11),
(39911, 3765, 0, 0, 0, 1101, 2, 1, 74, 11),
(39911, 3793, 0, 0, 0, 1101, 2, 1, 74, 11),
(39911, 3794, 0, 0, 0, 1101, 2, 1, 74, 11),
(39911, 3795, 0, 0, 0, 1101, 2, 1, 74, 11),
(39911, 3796, 0, 0, 0, 1101, 2, 1, 74, 11),
(39911, 3797, 0, 0, 0, 1101, 2, 1, 74, 11),
(39911, 3798, 0, 0, 0, 1101, 2, 1, 74, 11),
(39911, 3799, 0, 0, 0, 1101, 2, 1, 74, 11),
(39911, 3800, 0, 0, 0, 1101, 2, 1, 74, 11),
(39911, 3801, 0, 0, 0, 1101, 2, 1, 74, 11),
(39911, 3802, 0, 0, 0, 1101, 2, 1, 74, 11),
(39911, 3803, 0, 0, 0, 1101, 2, 1, 74, 11),
(39911, 3804, 0, 0, 0, 1101, 2, 1, 74, 11),
(39911, 3806, 0, 0, 0, 1101, 2, 1, 74, 11),
(39911, 3807, 0, 0, 0, 1101, 2, 1, 74, 11),
(39911, 3808, 0, 0, 0, 1101, 2, 1, 74, 11),
(39911, 3809, 0, 0, 0, 1101, 2, 1, 74, 11),
(39911, 3810, 0, 0, 0, 1101, 2, 1, 74, 11),
(39911, 3811, 0, 0, 0, 1101, 2, 1, 74, 11),
(39911, 3812, 0, 0, 0, 1101, 2, 1, 74, 11),
(39911, 3813, 0, 0, 0, 1101, 2, 1, 74, 11),
(39911, 3814, 0, 0, 0, 1101, 2, 1, 74, 11),
(39911, 3815, 0, 0, 0, 1101, 2, 1, 74, 11),
(39911, 3816, 0, 0, 0, 1101, 2, 1, 74, 11),
(39911, 3835, 0, 0, 0, 1101, 2, 1, 74, 11),
(39911, 3838, 0, 0, 0, 1101, 2, 1, 74, 11),
(39911, 3884, 0, 0, 0, 1101, 2, 1, 74, 11),
(39911, 3920, 0, 0, 0, 1101, 2, 1, 74, 11),
(39911, 3955, 0, 0, 0, 1101, 2, 1, 74, 11),
-- Hellfire Peninsula (Horde)
(39913, 3483, 0, 0, 0, 690, 2, 1, 74, 11),
(39913, 3536, 0, 0, 0, 690, 2, 1, 74, 11),
(39913, 3538, 0, 0, 0, 690, 2, 1, 74, 11),
(39913, 3539, 0, 0, 0, 690, 2, 1, 74, 11),
(39913, 3541, 0, 0, 0, 690, 2, 1, 74, 11),
(39913, 3542, 0, 0, 0, 690, 2, 1, 74, 11),
(39913, 3543, 0, 0, 0, 690, 2, 1, 74, 11),
(39913, 3544, 0, 0, 0, 690, 2, 1, 74, 11),
(39913, 3545, 0, 0, 0, 690, 2, 1, 74, 11),
(39913, 3546, 0, 0, 0, 690, 2, 1, 74, 11),
(39913, 3547, 0, 0, 0, 690, 2, 1, 74, 11),
(39913, 3548, 0, 0, 0, 690, 2, 1, 74, 11),
(39913, 3549, 0, 0, 0, 690, 2, 1, 74, 11),
(39913, 3550, 0, 0, 0, 690, 2, 1, 74, 11),
(39913, 3551, 0, 0, 0, 690, 2, 1, 74, 11),
(39913, 3552, 0, 0, 0, 690, 2, 1, 74, 11),
(39913, 3553, 0, 0, 0, 690, 2, 1, 74, 11),
(39913, 3554, 0, 0, 0, 690, 2, 1, 74, 11),
(39913, 3555, 0, 0, 0, 690, 2, 1, 74, 11),
(39913, 3556, 0, 0, 0, 690, 2, 1, 74, 11),
(39913, 3582, 0, 0, 0, 690, 2, 1, 74, 11),
(39913, 3669, 0, 0, 0, 690, 2, 1, 74, 11),
(39913, 3670, 0, 0, 0, 690, 2, 1, 74, 11),
(39913, 3671, 0, 0, 0, 690, 2, 1, 74, 11),
(39913, 3765, 0, 0, 0, 690, 2, 1, 74, 11),
(39913, 3793, 0, 0, 0, 690, 2, 1, 74, 11),
(39913, 3794, 0, 0, 0, 690, 2, 1, 74, 11),
(39913, 3795, 0, 0, 0, 690, 2, 1, 74, 11),
(39913, 3796, 0, 0, 0, 690, 2, 1, 74, 11),
(39913, 3797, 0, 0, 0, 690, 2, 1, 74, 11),
(39913, 3798, 0, 0, 0, 690, 2, 1, 74, 11),
(39913, 3799, 0, 0, 0, 690, 2, 1, 74, 11),
(39913, 3800, 0, 0, 0, 690, 2, 1, 74, 11),
(39913, 3801, 0, 0, 0, 690, 2, 1, 74, 11),
(39913, 3802, 0, 0, 0, 690, 2, 1, 74, 11),
(39913, 3803, 0, 0, 0, 690, 2, 1, 74, 11),
(39913, 3804, 0, 0, 0, 690, 2, 1, 74, 11),
(39913, 3806, 0, 0, 0, 690, 2, 1, 74, 11),
(39913, 3807, 0, 0, 0, 690, 2, 1, 74, 11),
(39913, 3808, 0, 0, 0, 690, 2, 1, 74, 11),
(39913, 3809, 0, 0, 0, 690, 2, 1, 74, 11),
(39913, 3810, 0, 0, 0, 690, 2, 1, 74, 11),
(39913, 3811, 0, 0, 0, 690, 2, 1, 74, 11),
(39913, 3812, 0, 0, 0, 690, 2, 1, 74, 11),
(39913, 3813, 0, 0, 0, 690, 2, 1, 74, 11),
(39913, 3814, 0, 0, 0, 690, 2, 1, 74, 11),
(39913, 3815, 0, 0, 0, 690, 2, 1, 74, 11),
(39913, 3816, 0, 0, 0, 690, 2, 1, 74, 11),
(39913, 3835, 0, 0, 0, 690, 2, 1, 74, 11),
(39913, 3838, 0, 0, 0, 690, 2, 1, 74, 11),
(39913, 3884, 0, 0, 0, 690, 2, 1, 74, 11),
(39913, 3920, 0, 0, 0, 690, 2, 1, 74, 11),
(39913, 3955, 0, 0, 0, 690, 2, 1, 74, 11);

-- Zeppelin transports
SET @RADIUS:=24; -- radius unknown
-- arrival events, play zeppelin horn
DELETE FROM `event_scripts` WHERE `command` = 16 and `id` IN (15312, 15314, 15318, 15320, 15322, 15324, 15430, 15431, 19126, 19127, 19137, 19139, 21868, 21870);
INSERT INTO `event_scripts` (`id`, `delay`, `command`, `datalong`, `datalong2`, `dataint`, `x`, `y`, `z`, `o`) VALUES
(15312, 0, 16, 11804, 4, @RADIUS, 0.0, 0.0, 0.0, 0.0),
(15314, 0, 16, 11804, 4, @RADIUS, 0.0, 0.0, 0.0, 0.0),
(15318, 0, 16, 11804, 4, @RADIUS, 0.0, 0.0, 0.0, 0.0),
(15320, 0, 16, 11804, 4, @RADIUS, 0.0, 0.0, 0.0, 0.0),
(15322, 0, 16, 11804, 4, @RADIUS, 0.0, 0.0, 0.0, 0.0),
(15324, 0, 16, 11804, 4, @RADIUS, 0.0, 0.0, 0.0, 0.0),
(15430, 0, 16, 11804, 4, @RADIUS, 0.0, 0.0, 0.0, 0.0),
(15431, 0, 16, 11804, 4, @RADIUS, 0.0, 0.0, 0.0, 0.0),
(19126, 0, 16, 11804, 4, @RADIUS, 0.0, 0.0, 0.0, 0.0),
(19127, 0, 16, 11804, 4, @RADIUS, 0.0, 0.0, 0.0, 0.0),
(19137, 0, 16, 11804, 4, @RADIUS, 0.0, 0.0, 0.0, 0.0),
(19139, 0, 16, 11804, 4, @RADIUS, 0.0, 0.0, 0.0, 0.0),
(21868, 0, 16, 11804, 4, @RADIUS, 0.0, 0.0, 0.0, 0.0),
(21870, 0, 16, 11804, 4, @RADIUS, 0.0, 0.0, 0.0, 0.0);

-- The Iron Eagle - Grom'Gol to Orgrimmar
UPDATE `gameobject_template` SET `ScriptName` = 'go_transport_the_iron_eagle' WHERE (`entry` = 175080);

-- Snurk Bucksquick Master Orgrimmar The Iron Eagle
DELETE FROM `gossip_menu_option` WHERE `MenuID` = 3841;
INSERT INTO `gossip_menu_option` (`MenuID`, `OptionID`, `OptionIcon`, `OptionText`, `OptionBroadcastTextID`, `OptionType`, `OptionNpcFlag`, `ActionMenuID`, `ActionPoiID`, `BoxCoded`, `BoxMoney`, `BoxText`, `BoxBroadcastTextID`, `VerifiedBuild`) VALUES
(3841, 0, 0, 'Where is the zeppelin now?', 22086, 1, 1, 8764, 0, 0, 0, '', 0, 0);
DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId` = 15) AND (`SourceGroup` = 3841) AND (`SourceEntry` = 0);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(15, 3841, 0, 0, 0, 103, 0, 175080, 15322, 0, 1, 0, 0, '', 'The zeppelin should not have just arrived at Orgrimmar');

-- Zez'raz Master Grom'gol The Iron Eagle
DELETE FROM `gossip_menu_option` WHERE `MenuID` = 2441;
INSERT INTO `gossip_menu_option` (`MenuID`, `OptionID`, `OptionIcon`, `OptionText`, `OptionBroadcastTextID`, `OptionType`, `OptionNpcFlag`, `ActionMenuID`, `ActionPoiID`, `BoxCoded`, `BoxMoney`, `BoxText`, `BoxBroadcastTextID`, `VerifiedBuild`) VALUES
(2441, 0, 0, 'Where is the zeppelin now?', 22086, 1, 1, 8764, 0, 0, 0, '', 0, 0);
DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId` = 15) AND (`SourceGroup` = 2441);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(15, 2441, 0, 0, 0, 103, 0, 175080, 15324, 0, 1, 0, 0, '', 'The zeppelin should not have just arrived at Grom\'gol');

-- Krixx Engineer Orgrimmar The Iron Eagle, The Thundercaller
DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId` = 14) AND (`SourceGroup` = 8764);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(14, 8764, 11167, 0, 0, 103, 0, 175080, 15324, 0, 0, 0, 0, '', 'The zeppelin should have just arrived at Grom\'gol'),
(14, 8764, 11169, 0, 1, 103, 0, 175080, 15322, 0, 0, 0, 0, '', 'The zeppelin should have just arrived at Orgrimmar'),
(14, 8764, 11170, 0, 2, 103, 0, 175080, 15323, 0, 0, 0, 0, '', 'The zeppelin should have just departed from Orgrimmar'),
(14, 8764, 11172, 0, 3, 103, 0, 175080, 15325, 0, 0, 0, 0, '', 'The zeppelin should have just departed from Grom\'gol'),
(14, 8764, 11163, 0, 4, 103, 0, 175080, 0, 0, 0, 0, 0, '', 'I\'m not sure where the zeppelin is right now, actually...');
DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId` = 14) AND (`SourceGroup` = 8765);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(14, 8765, 11165, 0, 0, 103, 0, 164871, 15318, 0, 0, 0, 0, '', 'The zeppelin should have just arrived at Orgrimmar'),
(14, 8765, 11173, 0, 1, 103, 0, 164871, 15320, 0, 0, 0, 0, '', 'The zeppelin should have just arrived at Undercity'),
(14, 8765, 11174, 0, 2, 103, 0, 164871, 15319, 0, 0, 0, 0, '', 'The zeppelin should have just departed from Orgrimmar'),
(14, 8765, 11175, 0, 3, 103, 0, 164871, 15321, 0, 0, 0, 0, '', 'The zeppelin should have just departed from Undercity'),
(14, 8765, 11163, 0, 4, 103, 0, 164871, 0, 0, 0, 0, 0, '', 'I\'m not sure where the zeppelin is right now, actually...');

-- The Thundercaller - Undercity to Orgrimmar
UPDATE `gameobject_template` SET `ScriptName` = 'go_transport_the_thundercaller' WHERE (`entry` = 164871);

-- Frezza Master Orgrimmar The Thundercaller
DELETE FROM `gossip_menu_option` WHERE `MenuID` = 1969;
INSERT INTO `gossip_menu_option` (`MenuID`, `OptionID`, `OptionIcon`, `OptionText`, `OptionBroadcastTextID`, `OptionType`, `OptionNpcFlag`, `ActionMenuID`, `ActionPoiID`, `BoxCoded`, `BoxMoney`, `BoxText`, `BoxBroadcastTextID`, `VerifiedBuild`) VALUES
(1969, 0, 0, 'Where is the zeppelin now?', 22086, 1, 1, 8765, 0, 0, 0, '', 0, 0);
DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId` = 15) AND (`SourceGroup` = 1969) AND (`SourceEntry` = 0);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(15, 1969, 0, 0, 0, 103, 0, 164871, 15318, 0, 1, 0, 0, '', 'The zeppelin should not have just arrived at Orgrimmar');

-- Zapetta Master Undercity The Thundercaller
DELETE FROM `gossip_menu_option` WHERE `MenuID` = 1971;
INSERT INTO `gossip_menu_option` (`MenuID`, `OptionID`, `OptionIcon`, `OptionText`, `OptionBroadcastTextID`, `OptionType`, `OptionNpcFlag`, `ActionMenuID`, `ActionPoiID`, `BoxCoded`, `BoxMoney`, `BoxText`, `BoxBroadcastTextID`, `VerifiedBuild`) VALUES
(1971, 0, 0, 'Where is the zeppelin now?', 22086, 1, 1, 8765, 0, 0, 0, '', 0, 0);
DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId` = 15) AND (`SourceGroup` = 1971) AND (`SourceEntry` = 0);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(15, 1971, 0, 0, 0, 103, 0, 164871, 15320, 0, 1, 0, 0, '', 'The zeppelin should not have just arrived at Undercity');
DELETE FROM `creature_text` WHERE (`CreatureID` = 9566) AND (`GroupID` = 1);
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(9566, 1, 0, 'There goes the zeppelin to Orgrimmar. I hope there\'s no explosions this time.', 12, 0, 100, 0, 0, 0, 22080, 0, 'Zapetta - Departure');
UPDATE `creature_text` SET `comment` = 'Zapetta - Arrival' WHERE (`CreatureID` = 9566) AND (`GroupID` = 0);

-- The Purple Princess - Grom'Gol to Undercity
UPDATE `gameobject_template` SET `ScriptName` = 'go_transport_the_purple_princess' WHERE (`entry` = 176495);

-- Hin Denburg Master Undercity The Purple Princess
DELETE FROM `gossip_menu` WHERE `MenuID` = 8766 AND `TextID` IN (11179, 11182);
INSERT INTO `gossip_menu` (`MenuID`, `TextID`) VALUES
(8766, 11179),
(8766, 11182);
DELETE FROM `gossip_menu_option` WHERE `MenuID` = 2101;
INSERT INTO `gossip_menu_option` (`MenuID`, `OptionID`, `OptionIcon`, `OptionText`, `OptionBroadcastTextID`, `OptionType`, `OptionNpcFlag`, `ActionMenuID`, `ActionPoiID`, `BoxCoded`, `BoxMoney`, `BoxText`, `BoxBroadcastTextID`, `VerifiedBuild`) VALUES
(2101, 0, 0, 'Where is the zeppelin now?', 22086, 1, 1, 8766, 0, 0, 0, '', 0, 0);
DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId` = 15) AND (`SourceGroup` = 2101) AND (`SourceEntry` = 0);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(15, 2101, 0, 0, 0, 103, 0, 176495, 15312, 0, 1, 0, 0, '', 'The zeppelin should not have just arrived at Undercity');

-- Squibby Overspeck Master Grom'gol The Purple Princess
DELETE FROM `gossip_menu_option` WHERE `MenuID` = 3842;
INSERT INTO `gossip_menu_option` (`MenuID`, `OptionID`, `OptionIcon`, `OptionText`, `OptionBroadcastTextID`, `OptionType`, `OptionNpcFlag`, `ActionMenuID`, `ActionPoiID`, `BoxCoded`, `BoxMoney`, `BoxText`, `BoxBroadcastTextID`, `VerifiedBuild`) VALUES
(3842, 0, 0, 'Where is the zeppelin now?', 22086, 1, 1, 8766, 0, 0, 0, '', 0, 0);
DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId` = 15) AND (`SourceGroup` = 3842) AND (`SourceEntry` = 0) AND (`SourceId` = 0);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(15, 3842, 0, 0, 0, 103, 0, 176495, 15314, 0, 1, 0, 0, '', 'The zeppelin should not have just arrived at Grom\'gol');

-- Kraxx Engineer Undercity The Thundercaller, The Purple Princess
DELETE FROM `gossip_menu_option` WHERE `MenuID` = 8786;
INSERT INTO `gossip_menu_option` (`MenuID`, `OptionID`, `OptionIcon`, `OptionText`, `OptionBroadcastTextID`, `OptionType`, `OptionNpcFlag`, `ActionMenuID`, `ActionPoiID`, `BoxCoded`, `BoxMoney`, `BoxText`, `BoxBroadcastTextID`, `VerifiedBuild`) VALUES
(8786, 0, 0, 'Where is the zeppelin to Orgrimmar right now?', 22185, 1, 1, 8765, 0, 0, 0, '', 0, 0),
(8786, 1, 0, 'Where is the zeppelin to Grom\'gol right now?', 22199, 1, 1, 8766, 0, 0, 0, '', 0, 0);
DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId` = 14) AND (`SourceGroup` = 8766);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(14, 8766, 11179, 0, 0, 103, 0, 176495, 15312, 0, 0, 0, 0, '', 'The zeppelin should have just arrived at Undercity'),
(14, 8766, 11180, 0, 1, 103, 0, 176495, 15314, 0, 0, 0, 0, '', 'The zeppelin should have just arrived at Grom\'gol'),
(14, 8766, 11182, 0, 2, 103, 0, 176495, 15313, 0, 0, 0, 0, '', 'The zeppelin should have just departed from Undercity'),
(14, 8766, 11181, 0, 3, 103, 0, 176495, 15315, 0, 0, 0, 0, '', 'The zeppelin should have just departed from Grom\'gol'),
(14, 8766, 11163, 0, 4, 103, 0, 176495, 0, 0, 0, 0, 0, '', 'I\'m not sure where the zeppelin is right now, actually...');

-- I\'m not sure where the zeppelin is right now, actually...
DELETE FROM `gossip_menu` WHERE (`MenuID` IN (8764, 8765, 8766)) and `TextID` = 11163;
INSERT INTO `gossip_menu` (`MenuID`, `TextID`) VALUES
(8764, 11163),
(8765, 11163),
(8766, 11163);
