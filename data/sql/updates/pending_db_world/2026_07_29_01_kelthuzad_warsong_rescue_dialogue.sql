-- Issue #22626: Kel'Thuzad and the rescuable "Injured Warsong" soldiers on the Plains of
-- Nasam (quest 11652, Borean Tundra) never speak. Kel'Thuzad already has his yell line in
-- creature_text (26163) but nothing ever calls SMART_ACTION_TALK on it - he only casts
-- Unholy Frenzy and plays the cackle sound (8818). The three confirmed soldiers (Warrior,
-- Mage, Engineer - lines and sources per issue comments) have no creature_text at all.
-- Injured Warsong Proxy (27109) is a non-spawned KillCredit-only entry (Wowhead: "location
-- unknown"), not a real NPC, so it needs no line. Injured Warsong Shaman (27108) still needs
-- one - its retail text couldn't be confirmed anywhere, left out of this fix.
DELETE FROM `creature_text` WHERE `CreatureID` IN (27106, 27107, 27110) AND `GroupID` = 0 AND `ID` = 0;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(27106, 0, 0, 'I will protect you, friend!', 12, 0, 100, 0, 0, 0, 0, 0, 'Injured Warsong Warrior - Rescued'),
(27107, 0, 0, 'Thank you, friend. Now these beasts shall feel the fury of the Sunwell!', 12, 0, 100, 0, 0, 0, 0, 0, 'Injured Warsong Mage - Rescued'),
(27110, 0, 0, 'Thanks, buddy! Let\'s see if I can\'t get this hunk o\' junk movin\' faster!', 12, 0, 100, 0, 0, 0, 0, 0, 'Injured Warsong Engineer - Rescued');

-- Kel'Thuzad: chain the yell onto his existing Out of Combat pulse, after the cackle sound.
-- Goes through a 1-row timed action list instead of a plain 0-delay link: SOUND (action_type
-- 4) only queues the clip client-side and returns immediately, so a same-tick TALK would
-- start reading the line while the cackle is still playing. ~2.5s is a best-effort estimate
-- for the cackle's length (SoundEntries.dbc doesn't carry clip duration) - adjust if it
-- turns out to be off once someone can compare against the actual clip.
DELETE FROM `smart_scripts` WHERE `entryorguid` = 25465 AND `source_type` = 0 AND `id` = 3;
UPDATE `smart_scripts` SET `link` = 3 WHERE `entryorguid` = 25465 AND `source_type` = 0 AND `id` = 1;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(25465, 0, 3, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 80, 2546500, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Kel\'Thuzad - Out of Combat - Call Timed Actionlist (Talk after cackle)');

DELETE FROM `smart_scripts` WHERE `entryorguid` = 2546500 AND `source_type` = 9;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2546500, 9, 0, 0, 0, 0, 100, 0, 2500, 2500, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Kel\'Thuzad - Actionlist - Talk Line 0 (after cackle)');

-- Warrior/Mage/Engineer: chain the thank-you line between the killcredit cast and the
-- 1-second despawn that already exists on each of them.
DELETE FROM `smart_scripts` WHERE `entryorguid` IN (27106, 27107, 27110) AND `source_type` = 0 AND `id` = 2;
UPDATE `smart_scripts` SET `link` = 2 WHERE `entryorguid` IN (27106, 27107, 27110) AND `source_type` = 0 AND `id` = 0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(27106, 0, 2, 1, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Injured Warsong Warrior - On Spell Hit - Talk Line 0'),
(27107, 0, 2, 1, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Injured Warsong Mage - On Spell Hit - Talk Line 0'),
(27110, 0, 2, 1, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Injured Warsong Engineer - On Spell Hit - Talk Line 0');
