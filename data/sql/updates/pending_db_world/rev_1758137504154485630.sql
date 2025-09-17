--
DELETE FROM `creature_template` WHERE (`entry` = 940 AND `name` = 'Kurzen Medicine Man');
INSERT INTO `creature_template` (`entry`, `difficulty_entry_1`, `difficulty_entry_2`, `difficulty_entry_3`, `KillCredit1`, `KillCredit2`, `name`, `subname`, `IconName`, `gossip_menu_id`, `minlevel`, `maxlevel`, `exp`, `faction`, `npcflag`, `speed_walk`, `speed_run`, `speed_swim`, `speed_flight`, `detection_range`, `scale`, `rank`, `dmgschool`, `DamageModifier`, `BaseAttackTime`, `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`, `unit_flags`, `unit_flags2`, `dynamicflags`, `family`, `trainer_type`, `trainer_spell`, `trainer_class`, `trainer_race`, `type`, `type_flags`, `lootid`, `pickpocketloot`, `skinloot`, `PetSpellDataId`, `VehicleId`, `mingold`, `maxgold`, `AIName`, `MovementType`, `HoverHeight`, `HealthModifier`, `ManaModifier`, `ArmorModifier`, `ExperienceModifier`, `RacialLeader`, `movementId`, `RegenHealth`, `mechanic_immune_mask`, `spell_school_immune_mask`, `flags_extra`, `ScriptName`, `VerifiedBuild`) VALUES
(940, 0, 0, 0, 0, 0, 'Kurzen Medicine Man', NULL, NULL, 0, 32, 33, 0, 46, 0, 1, 1.14286, 1, 1, 18, 1, 0, 0, 1, 2000, 2000, 1, 1, 2, 0, 2048, 0, 0, 0, 0, 0, 0, 7, 0, 940, 940, 0, 0, 0, 42, 195, 'SmartAI', 1, 1, 1.1, 1, 1, 1, 0, 0, 1, 0, 0, 0, '', 12340);

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 940;

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 940);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(940, 0, 0, 0, 74, 0, 100, 0, 0, 0, 19900, 28900, 30, 0, 11, 6077, 0, 0, 0, 0, 0, 9, 0, 0, 0, 0, 0, 0, 0, 0, 'Kurzen Medicine Man - On Friendly Between 0-30% Health - Cast \'Renew\''),
(940, 0, 1, 0, 74, 0, 100, 0, 0, 0, 34300, 39100, 30, 0, 11, 6064, 1, 0, 0, 0, 0, 9, 0, 0, 0, 0, 0, 0, 0, 0, 'Kurzen Medicine Man - On Friendly Between 0-30% Health - Cast \'Heal\''),
(940, 0, 2, 0, 60, 0, 100, 0, 1000, 1000, 70000, 90000, 0, 0, 11, 602, 32, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Kurzen Medicine Man - On Update - Cast \'Inner Fire\''),
(940, 0, 3, 0, 2, 0, 100, 1, 0, 15, 0, 0, 0, 0, 25, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Kurzen Medicine Man - Between 0-15% Health - Flee For Assist'),
(940, 0, 4, 0, 2, 0, 100, 0, 0, 50, 3000, 16000, 0, 0, 11, 6064, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Kurzen Medicine Man - Between 0-50% Health - Cast \'Heal\''),
(940, 0, 5, 0, 2, 0, 100, 0, 0, 90, 16000, 24000, 30, 0, 11, 6077, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Kurzen Medicine Man - Between 0-90% Health - Cast \'Renew\'');

