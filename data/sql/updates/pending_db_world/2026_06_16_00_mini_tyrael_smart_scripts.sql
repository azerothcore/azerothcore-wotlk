-- Mini Tyrael (entry 29089): fix dance/follow behavior
-- Issue: https://github.com/azerothcore/azerothcore-wotlk/issues/19781
--
-- Root causes fixed:
-- 1. Spell 69205 (periodic trigger 30s) → spell 69204 → SMART_EVENT_SPELLHIT fired
--    SMART_ACTION_TALK unconditionally every 30s ("falls asleep"/"becomes enraged") spamming chat.
--    Fix: remove the SPELLHIT handler entirely. The pet no longer sleeps or enrages.
-- 2. Dance used SMART_ACTION_PLAY_EMOTE which freezes movement.
--    Fix: use SMART_ACTION_CAST with spell 54398 (Tyrael Dance, DUMMY aura visual)
--    which allows the pet to keep following while the animation plays. 60s cooldown on /dance.
-- 3. Pet followed at angle 180 (behind) with dist=1, drifting away from the player.
--    Fix: follow at angle 90 (beside) with dist=0 for a closer, tighter position.
-- 4. Pet dances automatically while the player is moving (UPDATE_OOC every 1s + condition).
--    Stops dancing when player stops, resumes when player moves again.
--
-- Spell reference:
--   54398: Tyrael Dance — SPELL_AURA_DUMMY with dance visual animation
--   SMARTCAST_TRIGGERED (2) + SMARTCAST_AURA_NOT_PRESENT (32) = castFlags 34
--
-- Condition reference (conditions table):
--   SourceTypeOrReferenceId=22 (CONDITION_SOURCE_TYPE_SMART_EVENT)
--   SourceGroup = event_id + 1
--   ConditionTypeOrReference=21 (CONDITION_UNIT_STATE)
--   ConditionTarget=1 (GetBaseObject = the pet itself)
--   ConditionValue1=1048576 (UNIT_STATE_MOVE = 0x00100000)
--   Event id=2 (UPDATE dance):    SourceGroup=3, NegativeCondition=0  → only when IS moving
--   Event id=3 (UPDATE no-dance): SourceGroup=4, NegativeCondition=1  → only when NOT moving

DELETE FROM `smart_scripts` WHERE `entryorguid` IN (29089, 2908900, 2908901, 2908902) AND `source_type` IN (0, 9);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
-- On /dance emote received: cast Tyrael Dance spell (triggered, 60s cooldown)
(29089, 0, 0, 0, 22, 0, 100, 0, 34, 60000, 60000, 0, 0, 0, 11, 54398, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Mini Tyrael - On Receive Emote Dance: Cast Tyrael Dance'),
-- On summoned: follow owner beside (dist=0, angle=90 degrees)
(29089, 0, 1, 0, 54, 0, 100, 0, 0, 0, 0, 0, 0, 0, 29, 0, 90, 0, 0, 0, 0, 23, 0, 0, 0, 0, 0, 0, 0, 0, 'Mini Tyrael - On Summoned: Follow owner beside'),
-- Update OOC every 1s: cast Tyrael Dance (triggered, aura-not-present) when pet is moving
(29089, 0, 2, 0, 2, 0, 100, 0, 1000, 1000, 0, 0, 0, 0, 11, 54398, 34, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Mini Tyrael - Update OOC: Cast dance while moving'),
-- Update OOC every 1s: remove Tyrael Dance aura when pet is stationary
(29089, 0, 3, 0, 2, 0, 100, 0, 1000, 1000, 0, 0, 0, 0, 28, 54398, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Mini Tyrael - Update OOC: Remove dance when stationary');
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 22 AND `SourceEntry` = 29089 AND `SourceId` = 0;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
-- event id=2 UPDATE_OOC cast dance (SourceGroup=3): only fire when pet IS moving
(22, 3, 29089, 0, 0, 21, 1, 1048576, 0, 0, 0, 0, 0, '', 'Mini Tyrael - Update OOC dance only when moving'),
-- event id=3 UPDATE_OOC remove dance (SourceGroup=4): only fire when pet is NOT moving
(22, 4, 29089, 0, 0, 21, 1, 1048576, 0, 0, 1, 0, 0, '', 'Mini Tyrael - Update OOC stop dance only when stationary');
