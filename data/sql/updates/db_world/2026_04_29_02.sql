-- DB update 2026_04_29_01 -> 2026_04_29_02
--
-- Quest 12943 "Shadow Vault Decree" - Thane Ufrang the Mighty (29919)
--
-- The CheckCast "Thane is nearby" check moves out of spell_q12943_shadow_vault_decree
-- and into a CONDITION_NEAR_CREATURE on spell 31696. The script now also clears
-- Thane's idle unit flags via ReplaceAllUnitFlags before calling AttackStart, so
-- combat actually engages instead of the player getting stuck unable to attack.
--
-- The old SAI "Remove Unit Flags" action (id 6) chained off the 12s "Say Line 4"
-- timer is removed - the C++ handles flag removal at cast time.
--

-- Cast-time precondition: Thane (alive) must be within 30y of the caster.
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 17 AND `SourceEntry` = 31696;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(17, 0, 31696, 0, 0, 29, 0, 29919, 30, 0, 0, 12, 0, '', 'Spell Shadow Vault Decree requires nearby Thane Ufrang the Mighty');

-- Drop the now-redundant linked Remove-Unit-Flags action and its parent's link to it.
UPDATE `smart_scripts` SET `link` = 0 WHERE `entryorguid` = 29919 AND `source_type` = 0 AND `id` = 5;
DELETE FROM `smart_scripts` WHERE `entryorguid` = 29919 AND `source_type` = 0 AND `id` = 6;
