DELETE FROM `smart_scripts` WHERE `entryorguid` = 24978 AND `source_type` = 0;

-- Out-of-combat Fel Armor casting
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `target_type`, `comment`)
VALUES
(24978, 0, 0, 0, 11, 0, 100, 1, 0, 0, 0, 0, 11, 44977, 1, 'Dawnblade Summoner - On Respawn - Cast \'Fel Armor\'');

-- Out-of-combat Imp Summon
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `target_type`, `comment`)
VALUES
(24978, 0, 1, 0, 1, 0, 100, 0, 8000, 30000, 120000, 500000, 11, 11939, 1, 'Dawnblade Summoner - Out of Combat - Cast \'Summon Imp\'');

-- In-combat Incinerate casting every 8-12 seconds
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `target_type`, `comment`)
VALUES
(24978, 0, 2, 0, 0, 0, 100, 0, 2000, 4000, 8000, 12000, 11, 32707, 2, 'Dawnblade Summoner - In Combat - Cast \'Incinerate\'');

-- In-combat Immolate casting every 15-18 seconds
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `target_type`, `comment`)
VALUES
(24978, 0, 3, 0, 0, 0, 100, 0, 15000, 18000, 25000, 30000, 11, 11962, 2, 'Dawnblade Summoner - In Combat - Cast \'Immolate\'');

-- Enable combat movement when mana is below 21% (switch to melee)
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `action_type`, `action_param1`, `target_type`, `comment`)
VALUES
(24978, 0, 4, 0, 3, 0, 100, 0, 0, 21, 21, 1, 0, 'Dawnblade Summoner - Enable Combat Movement when mana is below 21%');

-- Disable combat movement when mana is above 21% (stay as a caster)
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `action_type`, `action_param1`, `target_type`, `comment`)
VALUES
(24978, 0, 5, 0, 3, 0, 100, 0, 22, 100, 21, 0, 0, 'Dawnblade Summoner - Disable Combat Movement when mana is above 21%');
