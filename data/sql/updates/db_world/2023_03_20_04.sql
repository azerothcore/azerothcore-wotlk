-- DB update 2023_03_20_03 -> 2023_03_20_04
--
UPDATE `creature_template_addon` SET `auras` = '11838 31261 36716' WHERE (`entry` = 20869);
UPDATE `creature_template_addon` SET `auras` = '11838 31261 38828' WHERE (`entry` = 21586);

DELETE FROM `spelldifficulty_dbc` WHERE `ID` IN (36719, 36716);
INSERT INTO `spelldifficulty_dbc` (`ID`, `DifficultySpellID_1`, `DifficultySpellID_2`) VALUES
(36719, 36719, 38830),
(36716, 36716, 38828);

UPDATE `spell_dbc` SET `Effect_1` = 28, `EffectMiscValueB_1` = 64, `EffectBasePoints_1` = 0 WHERE `ID`=37394;

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` IN (20869, 21303, 21304));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(20869, 0, 0, 0, 4, 0, 100, 512, 0, 0, 0, 0, 0, 142, 40, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Arcatraz Sentinel - On Aggro - Set Health 40%'),
(20869, 0, 1, 0, 25, 0, 100, 512, 0, 0, 0, 0, 0, 8, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Arcatraz Sentinel - On Reset - Set Reactstate Aggressive'),
(20869, 0, 2, 0, 4 , 0, 100, 512, 0, 0, 0, 0, 0, 28, 31261, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Arcatraz Sentinel - On Aggro - Remove Aura \'Permanent Feign Death (Root)\''),
(20869, 0, 3, 0, 2 , 0, 100, 1, 0, 10, 0, 0, 0, 11, 36719, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Arcatraz Sentinel - Between 0-10% Health - Cast \'Explode\' (No Repeat)'),
(20869, 0, 4, 0, 6 , 0, 100, 512, 0, 0, 0, 0, 0, 11, 37394, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Arcatraz Sentinel - On Death - Cast \'Summon Destroyed Sentinel\''),
(21303, 0, 0, 0, 4 , 0, 100, 0, 0, 0, 0, 0, 0, 80, 2130400, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Defender Corpse - On Aggro - Run Script'),
(21303, 0, 1, 0, 10, 0, 100, 1, 0, 8, 0, 0, 0, 80, 2130400, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Defender Corpse - Within 0-10 Range Out of Combat LoS - Run Script'),
(21304, 0, 0, 0, 4 , 0, 100, 0, 0, 0, 0, 0, 0, 80, 2130400, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Warder Corpse - On Aggro - Run Script'),
(21304, 0, 1, 0, 10, 0, 100, 1, 0, 8, 0, 0, 0, 80, 2130400, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Warder Corpse - Within 0-10 Range Out of Combat LoS - Run Script');

DELETE FROM `smart_scripts` WHERE (`source_type` = 9 AND `entryorguid` = 2130400);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2130400, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 11, 36599, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Warder/Defender Corpse - On Script - Cast \'Bloody Explosion\''),
(2130400, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 11, 36593, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Warder/Defender Corpse - On Script - Cast \'Corpse Burst\''),
(2130400, 9, 2, 0, 0, 0, 100, 0, 5000, 5000, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'WarderDefender Corpse - On Script - Despawn Instant');

-- Fix Templates - Sniffed unit flags
UPDATE `creature_template` SET `unit_flags` = 32832, `detection_range` = 10 WHERE (`entry` IN (21303, 21304, 21592, 21623));
UPDATE `creature_template` SET `unit_flags` = 64, `RegenHealth` = 0, `flags_extra` = `flags_extra`|2097152 WHERE (`entry` IN (20869, 21586));

-- Corpses are rooted
DELETE FROM `creature_template_movement` WHERE (`CreatureId` IN (21303, 21304, 21592, 21623));
INSERT INTO `creature_template_movement` (`CreatureId`, `Ground`, `Swim`, `Flight`, `Rooted`, `Chase`, `Random`, `InteractionPauseTimer`) VALUES
(21303, 0, 0, 0, 1, 0, 0, 0),
(21304, 0, 0, 0, 1, 0, 0, 0),
(21592, 0, 0, 0, 1, 0, 0, 0),
(21623, 0, 0, 0, 1, 0, 0, 0);

-- Destroyed Sentinel
DELETE FROM `creature_template_movement` WHERE (`CreatureId` = 21761);
INSERT INTO `creature_template_movement` (`CreatureId`, `Ground`, `Swim`, `Flight`, `Rooted`, `Chase`, `Random`, `InteractionPauseTimer`) VALUES
(21761, 0, 0, 1, 1, 0, 0, 0);
