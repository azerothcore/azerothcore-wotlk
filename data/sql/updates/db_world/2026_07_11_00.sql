-- DB update 2026_07_06_00 -> 2026_07_11_00
-- ---------------------------------------------------------------------------
-- Warden of the Chamber (30058)
-- ---------------------------------------------------------------------------
-- populate warden transform spells
-- Effect_1 = 6 (SPELL_EFFECT_APPLY_AURA), EffectAura_1 = 56
--   55831 Red    - 30072 (display 26747)
--   55830 Bronze - 30059 (display 26741)
--   55828 Blue   - 30076 (display 26749)
--   55829 Green  - 30073 (display 26748)
--   55827 Black  - 30077 (display 14308)
UPDATE `spell_dbc` SET `Effect_1` = 6, `EffectAura_1` = 56, `ImplicitTargetA_1` = 1, `EffectMiscValue_1` = 30072 WHERE `ID` = 55831;
UPDATE `spell_dbc` SET `Effect_1` = 6, `EffectAura_1` = 56, `ImplicitTargetA_1` = 1, `EffectMiscValue_1` = 30059 WHERE `ID` = 55830;
UPDATE `spell_dbc` SET `Effect_1` = 6, `EffectAura_1` = 56, `ImplicitTargetA_1` = 1, `EffectMiscValue_1` = 30076 WHERE `ID` = 55828;
UPDATE `spell_dbc` SET `Effect_1` = 6, `EffectAura_1` = 56, `ImplicitTargetA_1` = 1, `EffectMiscValue_1` = 30073 WHERE `ID` = 55829;
UPDATE `spell_dbc` SET `Effect_1` = 6, `EffectAura_1` = 56, `ImplicitTargetA_1` = 1, `EffectMiscValue_1` = 30077 WHERE `ID` = 55827;

-- creature_addon apply each warden transform as a passive spawn aura
-- per-GUID flight assignment
--   Blue   105487, 105495 - 55828
--   Bronze 105488, 105489 - 55830
--   Green  131055, 131058 - 55829
--   Red    131056, 131059 - 55831 + 29266 (Permanent Feign Death, 3.3.5a accurate)
--   Black  131063, 131064 - 55827
DELETE FROM `creature_addon` WHERE `guid` IN (105487, 105488, 105489, 105495, 131055, 131056, 131058, 131059, 131063, 131064);
INSERT INTO `creature_addon` (`guid`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `visibilityDistanceType`, `auras`) VALUES
(105487, 0, 0, 0, 1, 0, 0, '55828'),
(105488, 0, 0, 0, 1, 0, 0, '55830'),
(105489, 0, 0, 0, 1, 0, 0, '55830'),
(105495, 0, 0, 0, 1, 0, 0, '55828'),
(131055, 0, 0, 0, 1, 0, 0, '55829'),
(131056, 0, 0, 0, 1, 0, 0, '55831 29266'),
(131058, 0, 0, 0, 1, 0, 0, '55829'),
(131059, 0, 0, 0, 1, 0, 0, '55831 29266'),
(131063, 0, 0, 0, 1, 0, 0, '55827'),
(131064, 0, 0, 0, 1, 0, 0, '55827');

-- Red fire wall that blocks Ruby Sanctum (Invisible Stalker (23155) GUID 131066) stop spawn (intentional)
UPDATE `creature` SET `spawnMask` = 0 WHERE `guid` = 131066 AND `id` = 23155;

-- Correct blue warden 105487 orientation
UPDATE `creature` SET `orientation` = 2.990109920501708984 WHERE `guid` = 105487 AND `id` = 30058;

-- ---------------------------------------------------------------------------
-- Wyrmrest Protector (27953)
-- ---------------------------------------------------------------------------
-- populate protector transform spells
--   50158 Red    - 27952 (display 14357)
--   51118 Blue   - 28251 (display 14356)
--   50160 Bronze - 27955 (display 14358)
--   50159 Green  - 27954 (display 14359)
--   51117 Black  - 28250 (display 14355)
--   51119 Nether - 28252 (display 25257)
UPDATE `spell_dbc` SET `Effect_1` = 6, `EffectAura_1` = 56, `ImplicitTargetA_1` = 1, `EffectMiscValue_1` = 27952 WHERE `ID` = 50158;
UPDATE `spell_dbc` SET `Effect_1` = 6, `EffectAura_1` = 56, `ImplicitTargetA_1` = 1, `EffectMiscValue_1` = 28251 WHERE `ID` = 51118;
UPDATE `spell_dbc` SET `Effect_1` = 6, `EffectAura_1` = 56, `ImplicitTargetA_1` = 1, `EffectMiscValue_1` = 27955 WHERE `ID` = 50160;
UPDATE `spell_dbc` SET `Effect_1` = 6, `EffectAura_1` = 56, `ImplicitTargetA_1` = 1, `EffectMiscValue_1` = 27954 WHERE `ID` = 50159;
UPDATE `spell_dbc` SET `Effect_1` = 6, `EffectAura_1` = 56, `ImplicitTargetA_1` = 1, `EffectMiscValue_1` = 28250 WHERE `ID` = 51117;
UPDATE `spell_dbc` SET `Effect_1` = 6, `EffectAura_1` = 56, `ImplicitTargetA_1` = 1, `EffectMiscValue_1` = 28252 WHERE `ID` = 51119;

-- ---------------------------------------------------------------------------
-- SAI on respawn, roll 1 of 6 spells and apply spell transform
-- matching polearm is equipped depending what spell is selected
--   2795301 Red    - aura 50158, polearm 38488
--   2795302 Blue   - aura 51118, polearm 32729
--   2795303 Bronze - aura 50160, polearm 38491
--   2795304 Green  - aura 50159, polearm 38209
--   2795305 Black  - aura 51117, polearm 38487
--   2795306 Nether - aura 51119, polearm 38490
DELETE FROM `smart_scripts` WHERE `entryorguid` = 27953 AND `source_type` = 0 AND `id` = 4;
DELETE FROM `smart_scripts` WHERE `entryorguid` IN (2795301, 2795302, 2795303, 2795304, 2795305, 2795306) AND `source_type` = 9;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(27953, 0, 4, 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 87, 2795301, 2795302, 2795303, 2795304, 2795305, 2795306, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Wyrmrest Protector - On Respawn - Random flight transform + polearm'),
(2795301, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 75, 50158, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Wyrmrest Protector (Red) - Transform aura'),
(2795301, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 71, 0, 0, 38488, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Wyrmrest Protector (Red) - Equip polearm'),
(2795302, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 75, 51118, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Wyrmrest Protector (Blue) - Transform aura'),
(2795302, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 71, 0, 0, 32729, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Wyrmrest Protector (Blue) - Equip polearm'),
(2795303, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 75, 50160, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Wyrmrest Protector (Bronze) - Transform aura'),
(2795303, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 71, 0, 0, 38491, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Wyrmrest Protector (Bronze) - Equip polearm'),
(2795304, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 75, 50159, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Wyrmrest Protector (Green) - Transform aura'),
(2795304, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 71, 0, 0, 38209, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Wyrmrest Protector (Green) - Equip polearm'),
(2795305, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 75, 51117, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Wyrmrest Protector (Black) - Transform aura'),
(2795305, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 71, 0, 0, 38487, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Wyrmrest Protector (Black) - Equip polearm'),
(2795306, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 75, 51119, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Wyrmrest Protector (Nether) - Transform aura'),
(2795306, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 71, 0, 0, 38490, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Wyrmrest Protector (Nether) - Equip polearm');

-- 10 GUIDs are given emote state 173
DELETE FROM `creature_addon` WHERE `guid` IN (131012, 131014, 131015, 131016, 131020, 131021, 131022, 131023, 131026, 131027);
INSERT INTO `creature_addon` (`guid`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `visibilityDistanceType`, `auras`) VALUES
(131012, 0, 0, 0, 1, 173, 0, NULL),
(131014, 0, 0, 0, 1, 173, 0, NULL),
(131015, 0, 0, 0, 1, 173, 0, NULL),
(131016, 0, 0, 0, 1, 173, 0, NULL),
(131020, 0, 0, 0, 1, 173, 0, NULL),
(131021, 0, 0, 0, 1, 173, 0, NULL),
(131022, 0, 0, 0, 1, 173, 0, NULL),
(131023, 0, 0, 0, 1, 173, 0, NULL),
(131026, 0, 0, 0, 1, 173, 0, NULL),
(131027, 0, 0, 0, 1, 173, 0, NULL);

-- Reposition Protector spawn 131030 to its sniffed location
UPDATE `creature` SET `position_x` = 3452.6472, `position_y` = 250.009, `position_z` = 52.378803, `orientation` = 3.298672199249267578 WHERE `guid` = 131030 AND `id` = 27953;
