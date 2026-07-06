-- ============================================================================
-- Wyrmrest Temple Adjustments --
-- Correct Warden of the Chamber (30058) displayID and size (single model, scale 1).
-- SAI to correct displayID depending on what color beam that is being fired.
-- Mark the two Ruby Sanctum red wardens (131056, 131059) dead (Permanent Feign Death 29266).
-- Correct blue warden 105487 orientation to sniff.
-- Stop the Invisible Stalker (131066) from spawning (keep row for future use)
-- (accurate for Ruby Sanctum release).
-- Correct Wyrmrest Protector (27953) displayID (single base model).
-- SAI to roll a random dragonflight on respawn and equip the matching polearm.
-- Correct Protector polearm equip IDs (Red, Bronze, Nether) to sniff values.
-- Give selected Protectors the low weapon stance (EMOTE_STATE_WORK 173).
-- Relocate Protector 131030 to its sniffed spot, was incorrectly on mid-level
-- of the temple.
-- ============================================================================

-- ---------------------------------------------------------------------------
-- Warden of the Chamber (30058)
-- ---------------------------------------------------------------------------
-- Remove second displayid from pool, correct base
DELETE FROM `creature_template_model` WHERE `CreatureID` = 30058;
INSERT INTO `creature_template_model` (`CreatureID`, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`) VALUES
(30058, 0, 14308, 1, 1, 68275);

-- Per-flight morph action-lists (morphs respective GUIDs to correct display)
DELETE FROM `smart_scripts` WHERE `entryorguid` IN (3005801, 3005802, 3005803, 3005804, 3005805) AND `source_type` = 9;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(3005801, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 3, 0, 26747, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Warden of the Chamber - Red - Morph to display 26747'),
(3005802, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 3, 0, 26741, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Warden of the Chamber - Bronze - Morph to display 26741'),
(3005803, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 3, 0, 26749, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Warden of the Chamber - Blue - Morph to display 26749'),
(3005804, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 3, 0, 26748, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Warden of the Chamber - Green - Morph to display 26748'),
(3005805, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 3, 0, 14308, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Warden of the Chamber - Black - Morph to display 14308');

-- Per-GUID RESPAWN (morphs respective GUIDs to correct display)
DELETE FROM `smart_scripts` WHERE `entryorguid` IN (-131056, -131059, -131055, -131058, -105487, -105495, -105488, -105489) AND `source_type` = 0 AND `id` = 1;
DELETE FROM `smart_scripts` WHERE `entryorguid` IN (-131063, -131064) AND `source_type` = 0 AND `id` = 0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(-131056, 0, 1, 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 80, 3005801, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Warden of the Chamber - On Respawn - Red flight (morph)'),
(-131059, 0, 1, 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 80, 3005801, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Warden of the Chamber - On Respawn - Red flight (morph)'),
(-131055, 0, 1, 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 80, 3005804, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Warden of the Chamber - On Respawn - Green flight (morph)'),
(-131058, 0, 1, 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 80, 3005804, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Warden of the Chamber - On Respawn - Green flight (morph)'),
(-105487, 0, 1, 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 80, 3005803, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Warden of the Chamber - On Respawn - Blue flight (morph)'),
(-105495, 0, 1, 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 80, 3005803, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Warden of the Chamber - On Respawn - Blue flight (morph)'),
(-105488, 0, 1, 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 80, 3005802, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Warden of the Chamber - On Respawn - Bronze flight (morph)'),
(-105489, 0, 1, 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 80, 3005802, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Warden of the Chamber - On Respawn - Bronze flight (morph)'),
(-131063, 0, 0, 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 80, 3005805, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Warden of the Chamber - On Respawn - Black flight (morph)'),
(-131064, 0, 0, 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 80, 3005805, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Warden of the Chamber - On Respawn - Black flight (morph)');

-- Ruby Sanctum red wardens lie dead: GUIDs 131056 and 131059
-- Permanent Feign Death (29266) as a static spawn aura. (3.3.5a accurate)
DELETE FROM `creature_addon` WHERE `guid` IN (131056, 131059);
INSERT INTO `creature_addon` (`guid`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `visibilityDistanceType`, `auras`) VALUES
(131056, 0, 0, 0, 1, 0, 0, '29266'),
(131059, 0, 0, 0, 1, 0, 0, '29266');

-- Correct blue warden 105487 facing to the sniffed orientation
UPDATE `creature` SET `orientation` = 2.990109920501708984 WHERE `guid` = 105487;

-- The scaled Invisible Stalker (23155) GUID 131066 stop spawn
UPDATE `creature` SET `spawnMask` = 0 WHERE `guid` = 131066;

-- ---------------------------------------------------------------------------
-- Wyrmrest Protector (27953)
-- ---------------------------------------------------------------------------
-- Single base model (bronze 14358) at scale 1, replacing the random
-- 14355/14357/14358/14359 pool; per-spawn flight appearance is driven by the
-- roll below so the model never desyncs from its polearm.
DELETE FROM `creature_template_model` WHERE `CreatureID` = 27953;
INSERT INTO `creature_template_model` (`CreatureID`, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`) VALUES
(27953, 0, 14358, 1, 1, 68275);

-- On respawn, roll one of six equal-chance dragonflights (action 87). RESPAWN
-- (not RESET) so the flight is stable through combat and only re-rolls on a new
-- spawn life. Combat SAI (ids 0-3: Net / Sunder Armor / Cleave / Mortal Strike)
-- is untouched.
DELETE FROM `smart_scripts` WHERE `entryorguid` = 27953 AND `source_type` = 0 AND `id` = 4;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(27953, 0, 4, 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 87, 2795301, 2795302, 2795303, 2795304, 2795305, 2795306, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Wyrmrest Protector - On Respawn - Roll random dragonflight (morph + matching polearm)');

-- Flight action-lists: morph to the flight display (id 0) then equip its matching
-- polearm (id 1).
DELETE FROM `smart_scripts` WHERE `entryorguid` IN (2795301, 2795302, 2795303, 2795304, 2795305, 2795306) AND `source_type` = 9;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2795301, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 3, 0, 14357, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Wyrmrest Protector - Red - Morph to display 14357'),
(2795301, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 71, 0, 1, 38488, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Wyrmrest Protector - Red - Equip polearm 38488'),
(2795302, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 3, 0, 14358, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Wyrmrest Protector - Bronze - Morph to display 14358'),
(2795302, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 71, 0, 1, 38491, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Wyrmrest Protector - Bronze - Equip polearm 38491'),
(2795303, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 3, 0, 14356, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Wyrmrest Protector - Blue - Morph to display 14356'),
(2795303, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 71, 0, 1, 32729, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Wyrmrest Protector - Blue - Equip polearm 32729'),
(2795304, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 3, 0, 14359, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Wyrmrest Protector - Green - Morph to display 14359'),
(2795304, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 71, 0, 1, 38209, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Wyrmrest Protector - Green - Equip polearm 38209'),
(2795305, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 3, 0, 14355, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Wyrmrest Protector - Black - Morph to display 14355'),
(2795305, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 71, 0, 1, 38487, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Wyrmrest Protector - Black - Equip polearm 38487'),
(2795306, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 3, 0, 25257, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Wyrmrest Protector - Nether - Morph to display 25257'),
(2795306, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 71, 0, 1, 38490, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Wyrmrest Protector - Nether - Equip polearm 38490');

-- Selected Protectors hold the low weapon stance (EMOTE_STATE_WORK 173) with the
-- weapon kept drawn (bytes2 = 1 sheath state).
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

-- Relocate Protector 131030 from an unsniffed upper-floor spot (3542.56,
-- 313.813, 116.85) down to the sniffed west-archway position. It is already
-- MovementType 0 / no path; display + polearm come from the roll above.
UPDATE `creature` SET `position_x` = 3452.6472, `position_y` = 250.009, `position_z` = 52.378803, `orientation` = 3.298672199249267578 WHERE `guid` = 131030;
