-- Fix Infected Kodo Beast (entry 25596, quest 11690 "Bring 'Em Back Alive")
-- getting stuck standing and unable to be re-mounted after being forcibly
-- dismounted (e.g. by taking damage from hostile NPCs near Warsong Hold).
-- Its SmartAI only ever cleared the "Standstate Dead" flag on passenger
-- boarding, but never reapplied it afterwards, unlike every other
-- interact-to-mount/interact-to-loot NPC in the DB (Deathstalker Vincent,
-- Sentinel Keldara Sunblade, etc.), which pair "remove flag on
-- aggro/board" with "set flag on reset". Adds the missing "Set Flag
-- Standstate Dead" on Reset and on Passenger Removed so the kodo returns
-- to its expected lying-down/interactable pose instead of a broken
-- standing state.
-- https://github.com/azerothcore/azerothcore-wotlk/issues/26412
DELETE FROM `smart_scripts` WHERE `entryorguid` = 25596 AND `source_type` = 0;
INSERT INTO `smart_scripts`
    (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`,
     `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`,
     `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`,
     `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`,
     `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`,
     `target_x`, `target_y`, `target_z`, `target_o`, `comment`)
VALUES
    (25596, 0, 0, 0, 25, 0, 100, 512, 0, 0, 0, 0, 0, 0, 11, 32423, 0, 0, 0, 0, 0,
     1, 0, 0, 0, 0, 0, 0, 0, 0, 'Infected Kodo Beast - On Reset - Cast \'Blue Radiation\''),
    (25596, 0, 1, 0, 27, 0, 100, 512, 0, 0, 0, 0, 0, 0, 91, 7, 0, 0, 0, 0, 0,
     1, 0, 0, 0, 0, 0, 0, 0, 0, 'Infected Kodo Beast - On Passenger Boarded - Remove Flag Standstate Dead'),
    (25596, 0, 2, 0, 31, 0, 100, 512, 45877, 0, 0, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0,
     1, 0, 0, 0, 0, 0, 0, 0, 0, 'Infected Kodo Beast - On Target Spellhit \'Deliver Kodo\' - Despawn Instant'),
    (25596, 0, 3, 0, 25, 0, 100, 512, 0, 0, 0, 0, 0, 0, 90, 7, 0, 0, 0, 0, 0,
     1, 0, 0, 0, 0, 0, 0, 0, 0, 'Infected Kodo Beast - On Reset - Set Flag Standstate Dead'),
    (25596, 0, 4, 0, 28, 0, 100, 0, 0, 0, 0, 0, 0, 0, 90, 7, 0, 0, 0, 0, 0,
     1, 0, 0, 0, 0, 0, 0, 0, 0, 'Infected Kodo Beast - On Passenger Removed - Set Flag Standstate Dead');
