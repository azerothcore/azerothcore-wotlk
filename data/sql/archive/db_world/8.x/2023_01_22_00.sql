-- DB update 2023_01_21_03 -> 2023_01_22_00
-- Emote States
DELETE FROM `creature_addon` WHERE (`guid` IN (138669, 138670, 138671, 138672));
INSERT INTO `creature_addon` (`guid`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `visibilityDistanceType`, `auras`) VALUES
(138669, 0, 0, 0, 1, 375, 0, ''),
(138670, 0, 0, 0, 1, 375, 0, ''),
(138671, 0, 0, 0, 1, 375, 0, ''),
(138672, 0, 0, 0, 1, 375, 0, '');

-- Avian Ripper
UPDATE `creature_onkill_reputation` SET `RewOnKillRepValue1` = 2 WHERE (`creature_id` IN (21891, 21989));

-- Sethekk Initiate (Heroic)
DELETE FROM `creature_onkill_reputation` WHERE (`creature_id` = 20693);
INSERT INTO `creature_onkill_reputation` (`creature_id`, `RewOnKillRepFaction1`, `RewOnKillRepFaction2`, `MaxStanding1`, `IsTeamAward1`, `RewOnKillRepValue1`, `MaxStanding2`, `IsTeamAward2`, `RewOnKillRepValue2`, `TeamDependent`) VALUES
(20693, 1011, 0, 7, 0, 15, 0, 0, 0, 0);

-- Saga of Terokk
DELETE FROM `gameobject` WHERE `id` IN (183050, 183997) AND `guid` IN (7278, 7281);
UPDATE `gameobject` SET `spawntimesecs`=0 WHERE `id`=183050 AND `guid`=42095;

-- Sethekk Prophet
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 18325) AND (`source_type` = 0) AND (`id` IN (1, 2));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(18325, 0, 1, 0, 0, 0, 100, 0, 2000, 3000, 8000, 12000, 0, 11, 27641, 0, 0, 0, 0, 0, 5, 20, 0, 0, 0, 0, 0, 0, 0, 'Sethekk Prophet - In Combat - Cast \'Fear\''),
(18325, 0, 2, 0, 6, 0, 100, 0, 0, 0, 0, 0, 0, 11, 32692, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Sethekk Prophet - On Just Died - Cast \'Summon Arakkoa Spirit\'');

-- Fix Sethekk Spirit template and AI
UPDATE `creature_template` SET `speed_walk` = 1, `speed_run` = 0.285714, `unit_flags`=`unit_flags`|33587264, `flags_extra`=`flags_extra`|4194304 WHERE (`entry` IN  (18703, 20700));

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 18703;
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 18703);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(18703, 0, 0, 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 41, 10000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Sethekk Spirit - On Respawn - Despawn In 10000 ms');
