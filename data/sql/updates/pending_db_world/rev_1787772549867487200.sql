-- Alystros the Verdant Keeper
DELETE FROM `creature_template` WHERE (`entry` = 900001);
INSERT INTO `creature_template` (`entry`, `difficulty_entry_1`, `difficulty_entry_2`, `difficulty_entry_3`, `KillCredit1`, `KillCredit2`, `name`, `subname`, `IconName`, `gossip_menu_id`, `minlevel`, `maxlevel`, `exp`, `faction`, `npcflag`, `speed_walk`, `speed_run`, `speed_swim`, `speed_flight`, `detection_range`, `rank`, `dmgschool`, `DamageModifier`, `BaseAttackTime`, `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`, `unit_flags`, `unit_flags2`, `dynamicflags`, `family`, `type`, `type_flags`, `lootid`, `pickpocketloot`, `skinloot`, `PetSpellDataId`, `VehicleId`, `mingold`, `maxgold`, `AIName`, `MovementType`, `HoverHeight`, `HealthModifier`, `ManaModifier`, `ArmorModifier`, `ExperienceModifier`, `RacialLeader`, `movementId`, `RegenHealth`, `CreatureImmunitiesId`, `flags_extra`, `ScriptName`, `VerifiedBuild`) VALUES
(900001, 0, 0, 0, 0, 0, 'Alystros Lapsing Dream Trigger', '', NULL, 0, 74, 74, 2, 50, 0, 1, 0.992063, 1, 1, 18, 0, 0, 7.5, 2000, 2000, 1, 1, 1, 33555200, 2048, 0, 0, 10, 16778240, 0, 0, 0, 0, 0, 0, 0, 'SmartAI', 0, 1, 1.35, 1, 1, 1, 0, 0, 1, 0, 130, '', 0);

DELETE FROM `creature_template_model` WHERE (`CreatureID` = 900001);
INSERT INTO `creature_template_model` (`CreatureID`, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`) VALUES
(900001, 0, 169, 1, 1, 12340),
(900001, 1, 16925, 1, 1, 51831);

DELETE FROM `creature_template_addon` WHERE (`entry` = 900001);
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `visibilityDistanceType`, `auras`) VALUES
(900001, 0, 0, 1, 0, 0, 0, NULL);

DELETE FROM `smart_scripts` WHERE (`entryorguid` = 27249) AND (`source_type` = 0);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(27249, 0, 0, 0, 0, 0, 100, 0, 4000, 7000, 6000, 9000, 0, 0, 11, 51937, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Alystros the Verdant Keeper - In Combat - Cast \'Talon Strike\' (Phase 1) (No Repeat)'),
(27249, 0, 1, 0, 106, 0, 100, 0, 16000, 21000, 16000, 21000, 0, 5, 11, 51938, 1, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Alystros the Verdant Keeper - Within 0-5 Range - Cast \'Wing Beat\' (Phase 1) (No Repeat)'),
(27249, 0, 2, 0, 0, 0, 100, 0, 2500, 4000, 17000, 21000, 0, 0, 12, 900001, 3, 16000, 0, 0, 0, 5, 0, 1, 0, 0, 0, 0, 0, 0, 'Alystros the Verdant Keeper - In Combat - Summon Lapsing Dream Trigger At Random Player'),
(27249, 0, 3, 4, 38, 0, 100, 0, 1, 1, 0, 0, 0, 0, 17, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Alystros the Verdant Keeper - On Data Set - Set Emote State None'),
(27249, 0, 4, 5, 61, 0, 100, 512, 0, 0, 0, 0, 0, 0, 19, 768, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Alystros the Verdant Keeper - On Data Set - Set Unit Flags'),
(27249, 0, 5, 6, 61, 0, 100, 512, 0, 0, 0, 0, 0, 0, 4, 3605, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Alystros the Verdant Keeper - On Data Set - Play Sound 3605'),
(27249, 0, 6, 0, 61, 0, 100, 512, 0, 0, 0, 0, 0, 0, 49, 0, 0, 0, 0, 0, 0, 21, 100, 0, 0, 0, 0, 0, 0, 0, 'Alystros the Verdant Keeper - On Data Set - Attack');

DELETE FROM `smart_scripts` WHERE (`entryorguid` = 900001) AND (`source_type` = 0);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(900001, 0, 0, 0, 54, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 51922, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Lapsing Dream Trigger - On Just Summoned - Cast Lapsing Dream Smoke'),
(900001, 0, 1, 0, 60, 0, 100, 0, 0, 0, 500, 500, 0, 0, 75, 51928, 0, 0, 0, 0, 0, 18, 8, 0, 0, 0, 0, 0, 0, 0, 'Lapsing Dream Trigger - On Update - Refresh Debuff On Players Within 8 Yards');
