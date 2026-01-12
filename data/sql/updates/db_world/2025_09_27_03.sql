-- DB update 2025_09_27_02 -> 2025_09_27_03
--
-- Fjorlin Frostbrow SAI
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 29732);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(29732, 0, 0, 1, 62, 0, 100, 0, 9891, 0, 0, 0, 0, 0, 11, 56411, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Fjorlin Frostbrow - On Gossip Option 0 Selected - Cast \'Forcecast Summon Scripted Eagle\''),
(29732, 0, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 72, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Fjorlin Frostbrow - On Gossip Option 0 Selected - Close Gossip'),
(29732, 0, 2, 3, 62, 0, 100, 0, 9891, 1, 0, 0, 0, 0, 11, 57049, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Fjorlin Frostbrow - On Gossip Option 1 Selected - Self Cast \'Forcecast Summon Battle Eagle\''),
(29732, 0, 3, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 72, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Fjorlin Frostbrow - On Gossip Option 1 Selected - Close Gossip');

DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId` = 15) AND (`SourceGroup` = 9891) AND (`SourceEntry` = 0) AND (`SourceId` = 0) AND (`ElseGroup` = 0) AND (`ConditionTypeOrReference` IN (8, 9)) AND (`ConditionTarget` = 0) AND (`ConditionValue2` = 0) AND (`ConditionValue3` = 0);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(15, 9891, 0, 0, 0, 9, 0, 12874, 0, 0, 0, 0, 0, '', 'Show Frostborn gossip only when on quest \'Fervor of the Frostborn\' 12874');

-- 29736 Stormcrest Eagle (Scripted)
UPDATE `creature_template` SET `vehicleId`=196 WHERE `entry`=29736;

DELETE FROM `vehicle_template_accessory` WHERE `entry`=29736 AND `accessory_entry` IN (30401);
INSERT INTO `vehicle_template_accessory` (`entry`,`accessory_entry`,`seat_id`,`minion`,`description`,`summontype`,`summontimer`) VALUES
(29736, 30401, 0, 1, 'Stormcrest Eagle (Scripted)', 8, 0);

DELETE FROM `creature_template_spell` WHERE (`CreatureID` = 29736);

DELETE FROM `npc_spellclick_spells` WHERE `npc_entry`=29736;
INSERT INTO `npc_spellclick_spells` (`npc_entry`, `spell_id`, `cast_flags`, `user_type`) VALUES
(29736, 46598, 1, 0);

DELETE FROM `creature_template_addon` WHERE `entry`=29736;
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `auras`) VALUES
(29736, 0, 0, 0, 1, 0, '52211');

DELETE FROM `spell_target_position` WHERE `id`=55942;
INSERT INTO `spell_target_position` (`ID`, `EffectIndex`, `MapID`, `PositionX`, `PositionY`, `PositionZ`, `Orientation`, `VerifiedBuild`) VALUES
(55942, 0, 571, 6610.838379, -280.558685, 984.428772, 3.598404, 0);

DELETE FROM `waypoints` WHERE `entry`=29736 AND `pointid`=37;
INSERT INTO `waypoints` (`entry`, `pointid`, `position_x`, `position_y`, `position_z`, `point_comment`) VALUES
(29736, 37, 8405.069, -2071.5032, 1498.8086, 'Stormcrest eagle, Fervor of the Frostborn');

-- Updated comments with Keira. Added eject and despawn
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 29736);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(29736, 0, 0, 0, 60, 0, 100, 513, 1000, 1000, 0, 0, 0, 0, 53, 1, 29736, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Stormcrest Eagle - On Update - Start Waypoint Path 29736 (No Repeat)'),
(29736, 0, 1, 0, 27, 0, 100, 512, 0, 0, 0, 0, 0, 0, 81, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Stormcrest Eagle - On Passenger Boarded - Set Npc Flag '),
(29736, 0, 2, 0, 40, 0, 100, 512, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 19, 30401, 20, 0, 0, 0, 0, 0, 0, 'Stormcrest Eagle - On Point 3 of Path Any Reached - Say Line 0'),
(29736, 0, 3, 0, 40, 0, 100, 512, 7, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 19, 30401, 20, 0, 0, 0, 0, 0, 0, 'Stormcrest Eagle - On Point 7 of Path Any Reached - Say Line 1'),
(29736, 0, 4, 0, 40, 0, 100, 512, 10, 0, 0, 0, 0, 0, 1, 2, 0, 0, 0, 0, 0, 19, 30401, 20, 0, 0, 0, 0, 0, 0, 'Stormcrest Eagle - On Point 10 of Path Any Reached - Say Line 2'),
(29736, 0, 5, 0, 40, 0, 100, 512, 13, 0, 0, 0, 0, 0, 1, 3, 0, 0, 0, 0, 0, 19, 30401, 20, 0, 0, 0, 0, 0, 0, 'Stormcrest Eagle - On Point 13 of Path Any Reached - Say Line 3'),
(29736, 0, 6, 0, 40, 0, 100, 512, 15, 0, 0, 0, 0, 0, 1, 4, 0, 0, 0, 0, 0, 19, 30401, 20, 0, 0, 0, 0, 0, 0, 'Stormcrest Eagle - On Point 15 of Path Any Reached - Say Line 4'),
(29736, 0, 7, 0, 40, 0, 100, 512, 17, 0, 0, 0, 0, 0, 1, 5, 0, 0, 0, 0, 0, 19, 30401, 20, 0, 0, 0, 0, 0, 0, 'Stormcrest Eagle - On Point 17 of Path Any Reached - Say Line 5'),
(29736, 0, 8, 0, 40, 0, 100, 512, 19, 0, 0, 0, 0, 0, 1, 6, 0, 0, 0, 0, 0, 19, 30401, 20, 0, 0, 0, 0, 0, 0, 'Stormcrest Eagle - On Point 19 of Path Any Reached - Say Line 6'),
(29736, 0, 9, 0, 40, 0, 100, 512, 22, 0, 0, 0, 0, 0, 1, 7, 0, 0, 0, 0, 0, 19, 30401, 20, 0, 0, 0, 0, 0, 0, 'Stormcrest Eagle - On Point 22 of Path Any Reached - Say Line 7'),
(29736, 0, 10, 0, 40, 0, 100, 512, 24, 0, 0, 0, 0, 0, 1, 8, 0, 0, 0, 0, 0, 19, 30401, 20, 0, 0, 0, 0, 0, 0, 'Stormcrest Eagle - On Point 24 of Path Any Reached - Say Line 8'),
(29736, 0, 11, 0, 40, 0, 100, 512, 28, 0, 0, 0, 0, 0, 1, 9, 0, 0, 0, 0, 0, 19, 30401, 20, 0, 0, 0, 0, 0, 0, 'Stormcrest Eagle - On Point 28 of Path Any Reached - Say Line 9'),
(29736, 0, 12, 0, 40, 0, 100, 512, 30, 0, 0, 0, 0, 0, 1, 10, 0, 0, 0, 0, 0, 19, 30401, 20, 0, 0, 0, 0, 0, 0, 'Stormcrest Eagle - On Point 30 of Path Any Reached - Say Line 10'),
(29736, 0, 13, 0, 40, 0, 100, 512, 32, 0, 0, 0, 0, 0, 1, 11, 0, 0, 0, 0, 0, 19, 30401, 20, 0, 0, 0, 0, 0, 0, 'Stormcrest Eagle - On Point 32 of Path Any Reached - Say Line 11'),
(29736, 0, 14, 0, 40, 0, 100, 512, 34, 0, 0, 0, 0, 0, 1, 12, 0, 0, 0, 0, 0, 19, 30401, 20, 0, 0, 0, 0, 0, 0, 'Stormcrest Eagle - On Point 34 of Path Any Reached - Say Line 12'),
(29736, 0, 15, 16, 40, 0, 100, 512, 36, 0, 0, 0, 0, 0, 1, 13, 0, 0, 0, 0, 0, 19, 30401, 20, 0, 0, 0, 0, 0, 0, 'Stormcrest Eagle - On Point 36 of Path Any Reached - Say Line 13'),
(29736, 0, 16, 0, 61, 0, 100, 512, 0, 0, 0, 0, 0, 0, 11, 62539, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Stormcrest Eagle - On Point 36 of Path Any Reached - Cast \'Eject Passenger 2\''),
(29736, 0, 17, 0, 40, 0, 100, 512, 37, 0, 0, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Stormcrest Eagle - On Point 37 of Path Any Reached - Despawn Instant');
