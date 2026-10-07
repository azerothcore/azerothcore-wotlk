--
-- Issue #4091: Rothin the Decaying stands still instead of closing to melee when silenced.
--
-- Same conversion as the Dragonblight Anub'ar casters in 478d64959, applied to the one creature
-- that was split out of it. Rothin belongs to the Neltharion's Flame chain rather than the Anub'ar
-- camps, and he cannot be fought until that quest clears his immunity, so he was left for a change
-- that could be tested on its own.
--
-- Observed before the change, on the quest: silenced inside 40 yards he stands where he is for the
-- full five seconds. He is in melee stance throughout the fight, which is a symptom of the same
-- cause - with no main spell the core never puts him in range mode, so AttackStart leaves
-- auto-attack on - but the stance is not movement, and he never closes.
--
--   27355 Rothin the Decaying  Shadow Bolt 9613  range 40
--
-- The flag goes on the two Shadow Bolt rows only. Every successful flagged cast sets the chase
-- distance from that spell's range less melee reach, so Shadowflame 51337 and Aegis of Neltharion
-- 51512 stay unflagged: both are range 0, and flagging either would drop the standoff to melee every
-- time it landed. SmartAI::InitializeAI separately picks a main spell at spawn, taking the first
-- flagged non-positive cast it finds, which here is Shadow Bolt either way.
--
-- The repeating attack also moves off SMART_EVENT_RANGE onto SMART_EVENT_UPDATE_IC, and its target
-- from the action invoker to the victim. The range event passes the victim into the action, which
-- UPDATE_IC does not, so an invoker target would resolve to whoever first aggroed him and then to
-- nothing once that unit left. The event change is needed in its own right: the flag makes the core
-- hold position after a successful cast, and a gated cast is not attempted outside its window, so
-- nothing would report out of range and nothing would resume the chase.
--
-- The hand-rolled combat movement goes with it. SMART_ACTION_ALLOW_COMBAT_MOVEMENT calls
-- SetCombatMovement unconditionally, so "Within 5-15 Range - Disable Combat Movement" halts the very
-- charge the flag produces. Rothin's toggles carry no SMART_EVENT_FLAG_NOT_REPEATABLE and no repeat
-- interval, which leaves them active every tick, so that row fires continuously and he could never
-- cross 15 yards while silenced.
--
-- The phases go with them. Two things read a phase: the toggles, which are leaving, and the
-- repeating Shadow Bolt, which was gated on the phase entered on aggro so that it only ran in
-- combat. SMART_EVENT_UPDATE_IC already returns unless me->IsEngaged(), so that gate is covered
-- without a phase and nothing is left that needs one.
--
-- Everything unrelated to movement is kept: the immunity set on reset and removed by the data event,
-- all three say lines, Shadowflame and Aegis. Ids are renumbered and links repointed accordingly.
--
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 27355);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(27355, 0, 0, 0, 4, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 9613, 64, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Rothin the Decaying - On Aggro - Cast ''Shadow Bolt'''),
(27355, 0, 1, 0, 0, 0, 100, 0, 3400, 4800, 3400, 4800, 0, 0, 11, 9613, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Rothin the Decaying - In Combat - Cast ''Shadow Bolt'''),
(27355, 0, 2, 0, 0, 0, 100, 0, 12000, 17000, 15000, 20000, 0, 0, 11, 51337, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Rothin the Decaying - In Combat - Cast ''Shadowflame'''),
(27355, 0, 3, 0, 2, 0, 100, 1, 0, 30, 9500, 11000, 0, 0, 11, 51512, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Rothin the Decaying - Between 0-30% Health - Cast ''Aegis of Neltharion'' (No Repeat)'),
(27355, 0, 4, 0, 25, 0, 100, 512, 0, 0, 0, 0, 0, 0, 18, 768, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Rothin the Decaying - On Reset - Set Flags Immune To Players & Immune To NPC''s'),
(27355, 0, 5, 6, 38, 0, 100, 512, 1, 1, 0, 0, 0, 0, 45, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Rothin the Decaying - On Data Set 1 1 - Set Data 1 0'),
(27355, 0, 6, 7, 61, 0, 100, 512, 0, 0, 0, 0, 0, 0, 19, 768, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Rothin the Decaying - On Data Set 1 1 - Remove Flags Immune To Players & Immune To NPC''s'),
(27355, 0, 7, 0, 61, 0, 100, 512, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Rothin the Decaying - On Data Set 1 1 - Say Line 0'),
(27355, 0, 8, 0, 4, 0, 100, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Rothin the Decaying - On Aggro - Say Line 1'),
(27355, 0, 9, 0, 6, 0, 100, 0, 0, 0, 0, 0, 0, 0, 1, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Rothin the Decaying - On Just Died - Say Line 2');
