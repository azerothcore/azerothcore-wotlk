--
-- Issue #4091: casters stand still instead of closing to melee when they cannot cast.
--
-- The core drives ranged casters on its own. A cast row carrying SMARTCAST_COMBAT_MOVE (64) tells
-- SmartAI which spell is the creature's main attack, and it then chases to that spell's max range
-- less melee reach rather than running into melee, holds position between casts, and falls back to
-- melee whenever a cast fails - silence, pacify, out of mana, out of line of sight, immune target.
-- That behaviour was added in 23913 and refined in 27391.
--
-- Without the flag none of it applies: the creature has no main spell, so a failed cast changes
-- nothing and it stands there until whatever stopped it wears off. Silence one of these four and it
-- waits out the five seconds instead of closing the distance.
--
--   26319 Anub'ar Cultist      Shadow Bolt 9613  range 40
--   26607 Anub'ar Blightbeast  Poison Bolt 21971 range 30
--   26655 High Cultist Zangus  Shadow Bolt 9613  range 40
--   26770 Tivax the Breaker    Scorch 13878      range 30
--
-- Only the main attack gets the flag. The flag sets the chase distance from the spell's range, so
-- these are deliberately left unflagged - each would pull the creature off the standoff its main
-- attack asks for:
--   Zeal 51605             range 0, self
--   Empower 47257          out of combat buff
--   Fire Blast 20795       range 20, shorter than Tivax's 30
--   Blighted Shriek 47443  range 50, longer than the Blightbeast's 30
--
-- The repeating attack also moves off SMART_EVENT_RANGE onto SMART_EVENT_UPDATE_IC, because the two
-- do not mix. SMART_EVENT_RANGE only fires while the target is inside its range window, and the flag
-- makes the core hold the creature still after a successful cast until a later cast tells it
-- otherwise. Together that strands the creature: walk past the window and the cast is never attempted
-- again, so nothing ever reports out of range, so it never resumes chasing and eventually evades.
-- Running the cast unconditionally on its own 3400-4800 ms timer lets the out-of-range result do its
-- job, and it is how Arch Mage Xintor's casts are already written. The range gate is redundant
-- anyway, since the core derives the fighting distance from the flagged spell.
--
-- The hand-rolled combat movement goes with it, and that part is not optional. Each script switches
-- movement on and off by hand through a phase counter, a set of range-gated toggles, a mana-gated one
-- that enables movement below 7% mana, and a row that runs once out of combat. Those out-of-combat
-- rows are not uniform: 26655 and 26770 disable movement there, while 26319 and 26607 set
-- action_param1 = 1, which allows it, even though both rows are commented "Disable Combat Movement".
--
-- The core covers the mana case on its own now. An out-of-mana cast returns SPELL_FAILED_NO_POWER,
-- which is neither SPELL_CAST_OK nor out of range nor NOT_READY, so it takes the same branch as a
-- silence and sends the creature into melee.
--
-- What matters is the same on all four. SMART_ACTION_ALLOW_COMBAT_MOVEMENT calls SetCombatMovement
-- unconditionally, so "Within 5-15 Range - Disable Combat Movement" halts the melee charge the flag
-- exists to produce. It is flagged not-repeatable, so it fires once per reset - which is enough to
-- stall the charge for up to one cast cycle whenever the pull started outside 15 yards, since the
-- rows carry no repeat interval of their own.
--
-- The phase rows go with them. The phase entered on aggro gated the toggles and the main attack
-- both, so dropping it needs the attack to stay gated some other way, and SMART_EVENT_UPDATE_IC
-- already is: it returns unless me->IsEngaged(). Nothing else in these scripts reads a phase.
--
-- Everything unrelated to movement is kept: Tivax's Fire Blast and death line, Zangus' low-health
-- Zeal, the Blightbeast's Blighted Shriek, the Cultist's aggro Zeal and out-of-combat Empower. Ids
-- are renumbered and links repointed accordingly.
--
-- TrinityCore made this change first, every time by offl: 26770 in 407dcc9d75df, "DB/SAI: Update some
-- scripts using CMC cast flag or remove it", and 26607 and 26655 in 5c8930676352, "DB/SAI: Update
-- more scripts using CMC cast flag", both 2020-08-02; then 26319 in 9b088287b30e, "DB/SAI: Update
-- remaining scripts to new model using SMARTCAST_COMBAT_MOVE", 2021-01-29. Same flag, same event
-- type, same repeat interval and same target on the main attack, and the same combat-movement and
-- phase rows gone.
--
-- The blocks are not row-for-row identical, because only the combat-movement rows are in scope here:
-- TrinityCore's conversions also changed casts and timers that have nothing to do with movement, and
-- those are left as AC has them.
--
-- 26319 Anub'ar Cultist
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 26319);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(26319, 0, 0, 1, 4, 0, 100, 1, 0, 0, 0, 0, 0, 0, 11, 51605, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Anub''ar Cultist - On Aggro - Cast ''Zeal'' (No Repeat)'),
(26319, 0, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 9613, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Anub''ar Cultist - On Aggro - Cast ''Shadow Bolt'''),
(26319, 0, 2, 0, 0, 0, 100, 0, 3400, 4800, 3400, 4800, 0, 0, 11, 9613, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Anub''ar Cultist - In Combat - Cast ''Shadow Bolt'''),
(26319, 0, 3, 0, 1, 0, 100, 0, 3000, 6000, 15000, 35000, 0, 0, 11, 47257, 32, 0, 0, 0, 0, 11, 26607, 50, 0, 0, 0, 0, 0, 0, 'Anub''ar Cultist - Out of Combat - Cast Empower');

-- 26607 Anub'ar Blightbeast
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 26607);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(26607, 0, 0, 0, 4, 0, 100, 1, 0, 0, 0, 0, 0, 0, 11, 21971, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Anub''ar Blightbeast - On Aggro - Cast ''Poison Bolt'' (No Repeat)'),
(26607, 0, 1, 0, 0, 0, 100, 0, 3400, 4800, 3400, 4800, 0, 0, 11, 21971, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Anub''ar Blightbeast - In Combat - Cast ''Poison Bolt'''),
(26607, 0, 2, 0, 0, 0, 100, 0, 9000, 12000, 20000, 24000, 0, 0, 11, 47443, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 0, 'Anub''ar Blightbeast - In Combat - Cast ''Blighted Shriek''');

-- 26655 High Cultist Zangus
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 26655);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(26655, 0, 0, 0, 4, 0, 100, 1, 0, 0, 0, 0, 0, 0, 11, 9613, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'High Cultist Zangus - On Aggro - Cast ''Shadow Bolt'' (No Repeat)'),
(26655, 0, 1, 0, 0, 0, 100, 0, 3400, 4800, 3400, 4800, 0, 0, 11, 9613, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'High Cultist Zangus - In Combat - Cast ''Shadow Bolt'''),
(26655, 0, 2, 0, 2, 0, 100, 0, 0, 30, 120000, 125000, 0, 0, 11, 51605, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'High Cultist Zangus - Between 0-30% Health - Cast ''Zeal''');

-- 26770 Tivax the Breaker
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 26770);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(26770, 0, 0, 0, 4, 0, 100, 1, 0, 0, 0, 0, 0, 0, 11, 13878, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Tivax the Breaker - On Aggro - Cast ''Scorch'' (No Repeat)'),
(26770, 0, 1, 0, 0, 0, 100, 0, 3400, 4800, 3400, 4800, 0, 0, 11, 13878, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Tivax the Breaker - In Combat - Cast ''Scorch'''),
(26770, 0, 2, 0, 0, 0, 100, 0, 5000, 7000, 9000, 12000, 0, 0, 11, 20795, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 0, 'Tivax the Breaker - In Combat - Cast ''Fire Blast'''),
(26770, 0, 3, 0, 6, 0, 100, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Tivax the Breaker - On Just Died - Say Line 0');
