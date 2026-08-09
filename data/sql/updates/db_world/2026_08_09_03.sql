-- DB update 2026_08_09_02 -> 2026_08_09_03
--
DELETE FROM `areatrigger_scripts` WHERE `entry` = 4963;
INSERT INTO `areatrigger_scripts` (`entry`, `ScriptName`) VALUES (4963, 'SmartTrigger');

DELETE FROM `smart_scripts` WHERE (`source_type` = 2 AND `entryorguid` = 4963);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(4963, 2, 0, 0, 46, 0, 100, 0, 4963, 0, 0, 0, 0, 0, 45, 1, 1, 0, 0, 0, 0, 10, 107121, 25465, 0, 0, 0, 0, 0, 0, 'Areatrigger - On Trigger - Kel\'Thuzad Say Line'),
(4963, 2, 1, 0, 46, 0, 100, 0, 4963, 0, 0, 0, 0, 0, 15, 11652, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Areatrigger - On Trigger - Quest Credit \'The Plains of Nasam\'');

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 25465);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(25465, 0, 0, 1, 1, 0, 100, 0, 3000, 6000, 27000, 29000, 0, 0, 11, 50312, 32, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Kel\'Thuzad - Out of Combat - Cast \'Unholy Frenzy\''),
(25465, 0, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 4, 8818, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Kel\'Thuzad - Out of Combat - Play Sound 8818'),
(25465, 0, 2, 0, 38, 0, 100, 0, 1, 1, 60000, 60000, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Kel\'Thuzad - On Data Set from AreaTrigger - Say Line');

DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId` = 22) AND (`SourceGroup` = 1) AND (`SourceEntry` = 4963) AND (`SourceId` = 2) AND (`ElseGroup` = 0) AND (`ConditionTypeOrReference` = 47) AND (`ConditionTarget` = 0) AND (`ConditionValue1` = 11652) AND (`ConditionValue2` = 10) AND (`ConditionValue3` = 0);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(22, 1, 4963, 2, 0, 47, 0, 11652, 10, 0, 0, 0, 0, '', 'Kel\'Thuzad in Plains of Nasam only talks if the player is on the quest');

DELETE FROM `creature_text` WHERE (`CreatureID` = 27106);
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(27106, 0, 0, 'I will protect you, friend!', 12, 1, 100, 0, 0, 0, 26173, 0, 'Injured Warsong Warrior - Picked Up');

DELETE FROM `creature_text` WHERE (`CreatureID` = 27107);
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(27107, 0, 0, 'Thank you, friend. Now these beasts shall feel the fury of the Sunwell!', 12, 1, 100, 0, 0, 0, 26174, 0, 'Injured Warsong Mage - Picked Up');

DELETE FROM `creature_text` WHERE (`CreatureID` = 27110);
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(27110, 0, 0, 'Thanks, buddy! Let\'s see if I can\'t get this hunk o\' junk movin\' faster!', 12, 1, 100, 0, 0, 0, 26172, 0, 'Injured Warsong Engineer - Picked Up');

-- Shaman has NO text it seems

DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId` = 17) AND (`SourceGroup` = 0) AND (`SourceEntry` = 47962) AND (`SourceId` = 0) AND (`ElseGroup` = 3) AND (`ConditionTypeOrReference` = 31) AND (`ConditionTarget` = 1) AND (`ConditionValue1` = 3) AND (`ConditionValue2` = 27110) AND (`ConditionValue3` = 0);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(17, 0, 47962, 0, 3, 31, 1, 3, 27110, 0, 0, 0, 0, '', 'Requires Injured Soldier');

-- 'Rescue Injured Soldier' no longer hands out the credit on cast: the soldier now reports
-- the rescue with 'Soldier Rescued' (47968) once it actually got a seat, which then casts
-- 47967. Leaving the link in place credits every cast a second time.
DELETE FROM `spell_linked_spell` WHERE (`spell_trigger` = 47962) AND (`spell_effect` = 47967) AND (`type` = 0);

DELETE FROM `spell_script_names` WHERE (`spell_id` IN (47962, 47968));
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(47962, 'spell_q11652_rescue_injured_soldier'),
(47968, 'spell_q11652_soldier_rescued');

-- The Plains of Nasam (11652): rescued soldiers ride along in the Horde Siege Tank
-- instead of despawning. Boarding and the kill credit are handled by the scripts of
-- 'Rescue Injured Soldier' (47962) and 'Soldier Rescued' (47968).

-- The tank now carries passengers, so only the driver leaving may tear it down, and the
-- soldiers it picked up go with it.
DELETE FROM `smart_scripts` WHERE (`source_type` = 0) AND (`entryorguid` = 25334) AND (`id` IN (1, 2, 3, 4));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(25334, 0, 1, 2, 28, 0, 100, 0, 0, 0, 0, 0, 0, 0, 41, 1000, 0, 0, 0, 0, 0, 29, 1, 0, 0, 0, 0, 0, 0, 0, 'Horde Siege Tank - On Passenger Removed - Despawn Passenger In Seat 1 In 1000 ms'),
(25334, 0, 2, 3, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 41, 1000, 0, 0, 0, 0, 0, 29, 2, 0, 0, 0, 0, 0, 0, 0, 'Horde Siege Tank - On Passenger Removed - Despawn Passenger In Seat 2 In 1000 ms'),
(25334, 0, 3, 4, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 41, 1000, 0, 0, 0, 0, 0, 29, 3, 0, 0, 0, 0, 0, 0, 0, 'Horde Siege Tank - On Passenger Removed - Despawn Passenger In Seat 3 In 1000 ms'),
(25334, 0, 4, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 41, 1000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Horde Siege Tank - On Passenger Removed - Despawn In 1000 ms');

DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId` = 22) AND (`SourceGroup` = 2) AND (`SourceEntry` = 25334) AND (`SourceId` = 0);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(22, 2, 25334, 0, 0, 31, 0, 4, 0, 0, 0, 0, 0, '', 'Horde Siege Tank only despawns when the driver leaves, not when a rescued soldier does');

-- HACK: the tank is charmed by whoever drives it, so Unit::GetFactionReactionTo() resolves
-- everyone's reaction to it from the driver's Warsong Offensive standing (faction 1085, the
-- rescued soldiers' own faction) instead of comparing faction templates. At Neutral the soldiers
-- do not see the tank as friendly, so 'Warlord\'s Bulwark' (47975) and 'Tune Up!' (47969) - both
-- SPELL_EFFECT_APPLY_AREA_AURA_FRIEND - skip it. UNIT_FLAG2_IGNORE_REPUTATION (0x4) forces the
-- plain faction check. Sniff has Flags2 2048; revert this once the core stops proxying the
-- driver's reputation onto the vehicle.
UPDATE `creature_template` SET `unit_flags2` = `unit_flags2`|4 WHERE (`entry` = 25334);

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 27106);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(27106, 0, 0, 1, 31, 0, 100, 1, 47968, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Injured Warsong Warrior - On Target Spellhit \'Soldier Rescued\' - Say Line 0 (No Repeat)'),
(27106, 0, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 47975, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Injured Warsong Warrior - On Target Spellhit \'Soldier Rescued\' - Cast \'Warlord`s Bulwark\' (No Repeat)'),
(27106, 0, 2, 0, 0, 0, 100, 0, 0, 8000, 8000, 14000, 0, 0, 11, 39047, 0, 0, 0, 0, 0, 5, 5, 0, 0, 0, 0, 0, 0, 0, 'Injured Warsong Warrior - In Combat - Cast \'Cleave\''),
(27106, 0, 3, 0, 0, 0, 100, 0, 0, 8000, 8000, 14000, 0, 0, 11, 45026, 0, 0, 0, 0, 0, 5, 5, 0, 0, 0, 0, 0, 0, 0, 'Injured Warsong Warrior - In Combat - Cast \'Heroic Strike\'');

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 27107);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(27107, 0, 0, 0, 31, 0, 100, 1, 47968, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Injured Warsong Mage - On Target Spellhit \'Soldier Rescued\' - Say Line (No Repeat)'),
(27107, 0, 1, 0, 0, 0, 100, 0, 4000, 6000, 8000, 11000, 0, 0, 11, 34933, 0, 0, 0, 0, 0, 5, 10, 0, 0, 0, 0, 0, 0, 0, 'Injured Warsong Mage - In Combat - Cast \'Arcane Explosion\''),
(27107, 0, 2, 0, 0, 0, 100, 0, 9000, 16000, 18000, 22000, 0, 0, 11, 17274, 0, 0, 0, 0, 0, 5, 35, 0, 0, 0, 0, 0, 0, 0, 'Injured Warsong Mage - In Combat - Cast \'Pyroblast\'');

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 27108);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(27108, 0, 0, 0, 0, 0, 100, 0, 10000, 14000, 11000, 15000, 0, 0, 11, 25025, 0, 0, 0, 0, 0, 5, 20, 0, 0, 0, 0, 0, 0, 0, 'Injured Warsong Shaman - In Combat - Cast \'Earth Shock\''),
(27108, 0, 1, 0, 0, 0, 100, 0, 2000, 8000, 4000, 8000, 0, 0, 11, 16033, 0, 0, 0, 0, 0, 5, 30, 0, 0, 0, 0, 0, 0, 0, 'Injured Warsong Shaman - In Combat - Cast \'Chain Lightning\'');

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 27110);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(27110, 0, 0, 1, 31, 0, 100, 1, 47968, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Injured Warsong Engineer - On Target Spellhit \'Soldier Rescued\' - Say Line (No Repeat)'),
(27110, 0, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 47969, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Injured Warsong Engineer - On Target Spellhit \'Soldier Rescued\' - Cast \'Tune Up!\' (No Repeat)'),
(27110, 0, 2, 0, 0, 0, 100, 0, 10000, 14000, 11000, 15000, 0, 0, 11, 44273, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Injured Warsong Engineer - In Combat - Cast \'Goblin Dragon Gun\''),
(27110, 0, 3, 0, 0, 0, 100, 0, 10000, 14000, 42000, 48000, 0, 0, 11, 22742, 0, 0, 0, 0, 0, 5, 30, 0, 0, 0, 0, 0, 0, 0, 'Injured Warsong Engineer - In Combat - Cast \'Chain Lightning\'');

-- `creature_multispawn` feeds CreatureData::id2/id3, so a spawn point holds the base
-- `creature`.`id` plus at most 2 variants - ObjectMgr::LoadCreatures() drops any further rows
-- with an sql.sql error. Listing 27107/27108/27110 against a 27106 base put 27110 last in
-- (spawnId, entry) order, so the Engineer was the one dropped at every point and could never
-- spawn. Rotate which of the four each point leaves out instead.
UPDATE `creature` SET `id` = 27106 WHERE (`id` IN (27106, 27107, 27108, 27110)) AND (`guid` IN (117631,117632,117637,117639,117640,117642,117644,117645,117716,117730,117734,117755,117820,117822));
UPDATE `creature` SET `id` = 27107 WHERE (`id` IN (27106, 27107, 27108, 27110)) AND (`guid` IN (117638,117643,117724,117756));

-- fwiw we should allow multispawn to have >=4 entries
DELETE FROM `creature_multispawn` WHERE `spawnId` IN (117631,117632,117637,117638,117639,117640,117642,117643,117644,117645,117716,117724,117730,117734,117755,117756,117820,117822) AND `entry` IN (27106, 27107, 27108, 27110);
INSERT INTO `creature_multispawn` (`spawnId`, `entry`) VALUES
-- Warrior / Mage / Shaman
(117631, 27107), (117631, 27108),
(117639, 27107), (117639, 27108),
(117644, 27107), (117644, 27108),
(117730, 27107), (117730, 27108),
(117820, 27107), (117820, 27108),
-- Warrior / Mage / Engineer
(117632, 27107), (117632, 27110),
(117640, 27107), (117640, 27110),
(117645, 27107), (117645, 27110),
(117734, 27107), (117734, 27110),
(117822, 27107), (117822, 27110),
-- Warrior / Shaman / Engineer
(117637, 27108), (117637, 27110),
(117642, 27108), (117642, 27110),
(117716, 27108), (117716, 27110),
(117755, 27108), (117755, 27110),
-- Mage / Shaman / Engineer
(117638, 27108), (117638, 27110),
(117643, 27108), (117643, 27110),
(117724, 27108), (117724, 27110),
(117756, 27108), (117756, 27110);

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 27064);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(27064, 0, 0, 1, 103, 0, 100, 513, 0, 25334, 1, 2, 400, 0, 11, 47916, 2, 0, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Abandoned Fuel Tank - On 1 or More Units in Range - Cast \'Fuel\' (No Repeat)'),
(27064, 0, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 41, 4000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Abandoned Fuel Tank - On 1 or More Units in Range - Despawn In 4000 ms (No Repeat)'),
(27064, 0, 2, 0, 11, 0, 100, 512, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Abandoned Fuel Tank - On Respawn - Set Reactstate Passive');
