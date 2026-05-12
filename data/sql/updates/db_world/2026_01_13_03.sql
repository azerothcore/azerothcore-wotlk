-- DB update 2026_01_13_02 -> 2026_01_13_03
-- Fix: Rampage! quest chain-breaking mechanic for all 4 pillars

-- === CLEANUP ===
DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId` = 13) AND (`SourceGroup` = 1) AND (`SourceEntry` IN (52833, 52834, 52837, 52838)) AND (`SourceId` = 0) AND (`ElseGroup` = 0) AND (`ConditionTypeOrReference` = 31) AND (`ConditionValue1` = 3) AND (`ConditionValue2` = 26298);

-- Trigger bunny scripts (these interfered with the mechanic; keep them absent)
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` IN (-113478, -113479, -113550, -113551));

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` IN (-113549, -113548, -61994, -61995));
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` IN (-100336, -100333, -100335, -100334));
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = -61996);
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 28952);
DELETE FROM `smart_scripts` WHERE (`source_type` = 9 AND `entryorguid` IN (2895200, 2895201, 2895202));
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` IN (-101661,-101662,-101663,-101665,-101666,-101667,-101668,-101669,-203572,-203573,-203574,-203575,-203576,-203577));

DELETE FROM `creature_addon` WHERE (`guid` IN (100333, 100334, 100335, 100336));

-- === CONDITIONS: chain spells target trigger bunny GUIDs ===
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(13, 1, 52834, 0, 0, 31, 0, 3, 26298, 113551, 0, 0, 0, '', 'Rampage: Akali\'s Chains can only target specific paws'),
(13, 1, 52833, 0, 0, 31, 0, 3, 26298, 113550, 0, 0, 0, '', 'Rampage: Akali\'s Chains can only target specific paws'),
(13, 1, 52837, 0, 0, 31, 0, 3, 26298, 113478, 0, 0, 0, '', 'Rampage: Akali\'s Chains can only target specific paws'),
(13, 1, 52838, 0, 0, 31, 0, 3, 26298, 113479, 0, 0, 0, '', 'Rampage: Akali\'s Chains can only target specific paws');

-- === CHAIN BUNNIES (entry 26298, z~443) ===
-- Phase 1 = chain intact and ready to be broken; Phase 0 = chain broken
-- id=0: RESPAWN  -> CAST chain spell, link=1 (enter phase 1 on spawn/respawn)
-- id=1: LINK     -> SET PHASE 1 (shared target from RESPAWN and ACTION_DONE)
-- id=2: ACTION_DONE(10) -> CAST chain spell, link=1 (Akali reset: re-arm and re-enter phase 1)
-- id=3: SPELLHIT(52816), phase=1 -> REMOVE_AURA from trigger bunny, link=4
-- id=4: LINK, phase=1 -> DO_ACTION(11) on Akali (increment broken-chain counter), link=5
-- id=5: LINK     -> SET PHASE 0 (disarm until next reset)

-- Right Front Paw  GUID -113549 / chain spell 52834 / trigger bunny 113551
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(-113549, 0, 0, 1, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 52834, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'ELM General Purpose Bunny (scale x0.01) Large - On Spawn: Cast \'Rampage: Akali`s Chains - Right Front Paw\''),
(-113549, 0, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 22, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'ELM General Purpose Bunny (scale x0.01) Large - On Spawn/Reset: Set Event Phase 1'),
(-113549, 0, 2, 1, 72, 0, 100, 0, 10, 0, 0, 0, 0, 0, 11, 52834, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'ELM General Purpose Bunny (scale x0.01) Large - On Action 10 (Reset): Cast \'Rampage: Akali`s Chains - Right Front Paw\''),
(-113549, 0, 3, 4, 8, 1, 100, 512, 52816, 0, 0, 0, 0, 0, 28, 52834, 0, 0, 0, 0, 0, 10, 113551, 26298, 0, 0, 0, 0, 0, 0, 'ELM General Purpose Bunny (scale x0.01) Large - On Spellhit \'Rampage: Akali Chain Anchor On Disturb\': Remove Aura \'Rampage: Akali`s Chains - Right Front Paw\''),
(-113549, 0, 4, 5, 61, 1, 100, 0, 0, 0, 0, 0, 0, 0, 223, 11, 0, 0, 0, 0, 0, 10, 98159, 28952, 0, 0, 0, 0, 0, 0, 'ELM General Purpose Bunny (scale x0.01) Large - On Spellhit \'Rampage: Akali Chain Anchor On Disturb\': Do Action 11 On Akali - Right Front Paw Freed'),
(-113549, 0, 5, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 22, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'ELM General Purpose Bunny (scale x0.01) Large - On Spellhit \'Rampage: Akali Chain Anchor On Disturb\': Set Event Phase 0');

-- Left Front Paw  GUID -113548 / chain spell 52833 / trigger bunny 113550
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(-113548, 0, 0, 1, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 52833, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'ELM General Purpose Bunny (scale x0.01) Large - On Spawn: Cast \'Rampage: Akali`s Chains - Left Front Paw\''),
(-113548, 0, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 22, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'ELM General Purpose Bunny (scale x0.01) Large - On Spawn/Reset: Set Event Phase 1'),
(-113548, 0, 2, 1, 72, 0, 100, 0, 10, 0, 0, 0, 0, 0, 11, 52833, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'ELM General Purpose Bunny (scale x0.01) Large - On Action 10 (Reset): Cast \'Rampage: Akali`s Chains - Left Front Paw\''),
(-113548, 0, 3, 4, 8, 1, 100, 512, 52816, 0, 0, 0, 0, 0, 28, 52833, 0, 0, 0, 0, 0, 10, 113550, 26298, 0, 0, 0, 0, 0, 0, 'ELM General Purpose Bunny (scale x0.01) Large - On Spellhit \'Rampage: Akali Chain Anchor On Disturb\': Remove Aura \'Rampage: Akali`s Chains - Left Front Paw\''),
(-113548, 0, 4, 5, 61, 1, 100, 0, 0, 0, 0, 0, 0, 0, 223, 11, 0, 0, 0, 0, 0, 10, 98159, 28952, 0, 0, 0, 0, 0, 0, 'ELM General Purpose Bunny (scale x0.01) Large - On Spellhit \'Rampage: Akali Chain Anchor On Disturb\': Do Action 11 On Akali - Left Front Paw Freed'),
(-113548, 0, 5, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 22, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'ELM General Purpose Bunny (scale x0.01) Large - On Spellhit \'Rampage: Akali Chain Anchor On Disturb\': Set Event Phase 0');

-- Right Rear Paw  GUID -61994 / chain spell 52837 / trigger bunny 113478
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(-61994, 0, 0, 1, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 52837, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'ELM General Purpose Bunny (scale x0.01) Large - On Spawn: Cast \'Rampage: Akali`s Chains - Right Rear Paw\''),
(-61994, 0, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 22, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'ELM General Purpose Bunny (scale x0.01) Large - On Spawn/Reset: Set Event Phase 1'),
(-61994, 0, 2, 1, 72, 0, 100, 0, 10, 0, 0, 0, 0, 0, 11, 52837, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'ELM General Purpose Bunny (scale x0.01) Large - On Action 10 (Reset): Cast \'Rampage: Akali`s Chains - Right Rear Paw\''),
(-61994, 0, 3, 4, 8, 1, 100, 512, 52816, 0, 0, 0, 0, 0, 28, 52837, 0, 0, 0, 0, 0, 10, 113478, 26298, 0, 0, 0, 0, 0, 0, 'ELM General Purpose Bunny (scale x0.01) Large - On Spellhit \'Rampage: Akali Chain Anchor On Disturb\': Remove Aura \'Rampage: Akali`s Chains - Right Rear Paw\''),
(-61994, 0, 4, 5, 61, 1, 100, 0, 0, 0, 0, 0, 0, 0, 223, 11, 0, 0, 0, 0, 0, 10, 98159, 28952, 0, 0, 0, 0, 0, 0, 'ELM General Purpose Bunny (scale x0.01) Large - On Spellhit \'Rampage: Akali Chain Anchor On Disturb\': Do Action 11 On Akali - Right Rear Paw Freed'),
(-61994, 0, 5, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 22, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'ELM General Purpose Bunny (scale x0.01) Large - On Spellhit \'Rampage: Akali Chain Anchor On Disturb\': Set Event Phase 0');

-- Left Rear Paw  GUID -61995 / chain spell 52838 / trigger bunny 113479
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(-61995, 0, 0, 1, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 52838, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'ELM General Purpose Bunny (scale x0.01) Large - On Spawn: Cast \'Rampage: Akali`s Chains - Left Rear Paw\''),
(-61995, 0, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 22, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'ELM General Purpose Bunny (scale x0.01) Large - On Spawn/Reset: Set Event Phase 1'),
(-61995, 0, 2, 1, 72, 0, 100, 0, 10, 0, 0, 0, 0, 0, 11, 52838, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'ELM General Purpose Bunny (scale x0.01) Large - On Action 10 (Reset): Cast \'Rampage: Akali`s Chains - Left Rear Paw\''),
(-61995, 0, 3, 4, 8, 1, 100, 512, 52816, 0, 0, 0, 0, 0, 28, 52838, 0, 0, 0, 0, 0, 10, 113479, 26298, 0, 0, 0, 0, 0, 0, 'ELM General Purpose Bunny (scale x0.01) Large - On Spellhit \'Rampage: Akali Chain Anchor On Disturb\': Remove Aura \'Rampage: Akali`s Chains - Left Rear Paw\''),
(-61995, 0, 4, 5, 61, 1, 100, 0, 0, 0, 0, 0, 0, 0, 223, 11, 0, 0, 0, 0, 0, 10, 98159, 28952, 0, 0, 0, 0, 0, 0, 'ELM General Purpose Bunny (scale x0.01) Large - On Spellhit \'Rampage: Akali Chain Anchor On Disturb\': Do Action 11 On Akali - Left Rear Paw Freed'),
(-61995, 0, 5, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 22, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'ELM General Purpose Bunny (scale x0.01) Large - On Spellhit \'Rampage: Akali Chain Anchor On Disturb\': Set Event Phase 0');

-- === FIRE BUNNIES (entry 24110, z~445) ===
-- No phase needed: fire bunnies do not affect Akali's counter, REMOVE_AURA is a safe no-op if already gone
-- id=0: RESPAWN -> CAST fire aura on self
-- id=1: ACTION_DONE(10) -> CAST fire aura on self (Akali reset relay)
-- id=2: SPELLHIT(52816) -> REMOVE_AURA fire aura from self

-- Right Front Fire  GUID -100336
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(-100336, 0, 0, 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 52855, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'ELM General Purpose Bunny Large - On Spawn: Cast \'Cosmetic - Low Poly Fire (with Sound)\''),
(-100336, 0, 1, 0, 72, 0, 100, 0, 10, 0, 0, 0, 0, 0, 11, 52855, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'ELM General Purpose Bunny Large - On Action 10 (Reset): Cast \'Cosmetic - Low Poly Fire (with Sound)\''),
(-100336, 0, 2, 0, 8, 0, 100, 512, 52816, 0, 0, 0, 0, 0, 28, 52855, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'ELM General Purpose Bunny Large - On Spellhit \'Rampage: Akali Chain Anchor On Disturb\': Remove Aura \'Cosmetic - Low Poly Fire (with Sound)\'');

-- Left Front Fire  GUID -100333
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(-100333, 0, 0, 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 52855, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'ELM General Purpose Bunny Large - On Spawn: Cast \'Cosmetic - Low Poly Fire (with Sound)\''),
(-100333, 0, 1, 0, 72, 0, 100, 0, 10, 0, 0, 0, 0, 0, 11, 52855, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'ELM General Purpose Bunny Large - On Action 10 (Reset): Cast \'Cosmetic - Low Poly Fire (with Sound)\''),
(-100333, 0, 2, 0, 8, 0, 100, 512, 52816, 0, 0, 0, 0, 0, 28, 52855, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'ELM General Purpose Bunny Large - On Spellhit \'Rampage: Akali Chain Anchor On Disturb\': Remove Aura \'Cosmetic - Low Poly Fire (with Sound)\'');

-- Right Rear Fire  GUID -100335
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(-100335, 0, 0, 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 52855, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'ELM General Purpose Bunny Large - On Spawn: Cast \'Cosmetic - Low Poly Fire (with Sound)\''),
(-100335, 0, 1, 0, 72, 0, 100, 0, 10, 0, 0, 0, 0, 0, 11, 52855, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'ELM General Purpose Bunny Large - On Action 10 (Reset): Cast \'Cosmetic - Low Poly Fire (with Sound)\''),
(-100335, 0, 2, 0, 8, 0, 100, 512, 52816, 0, 0, 0, 0, 0, 28, 52855, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'ELM General Purpose Bunny Large - On Spellhit \'Rampage: Akali Chain Anchor On Disturb\': Remove Aura \'Cosmetic - Low Poly Fire (with Sound)\'');

-- Left Rear Fire  GUID -100334
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(-100334, 0, 0, 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 52855, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'ELM General Purpose Bunny Large - On Spawn: Cast \'Cosmetic - Low Poly Fire (with Sound)\''),
(-100334, 0, 1, 0, 72, 0, 100, 0, 10, 0, 0, 0, 0, 0, 11, 52855, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'ELM General Purpose Bunny Large - On Action 10 (Reset): Cast \'Cosmetic - Low Poly Fire (with Sound)\''),
(-100334, 0, 2, 0, 8, 0, 100, 512, 52816, 0, 0, 0, 0, 0, 28, 52855, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'ELM General Purpose Bunny Large - On Spellhit \'Rampage: Akali Chain Anchor On Disturb\': Remove Aura \'Cosmetic - Low Poly Fire (with Sound)\'');

-- === AKALI (entry 28952) ===
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(28952, 0, 0, 0, 77, 0, 100, 512, 1, 4, 0, 0, 0, 0, 80, 2895200, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Akali - On 4 Chains Broken - Run Quest Success Script'),
(28952, 0, 1, 2, 8, 0, 100, 512, 52859, 0, 0, 0, 0, 0, 102, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Akali - On Spellhit \'Submission\' - Set Health Regeneration Off'),
(28952, 0, 2, 3, 61, 0, 100, 512, 0, 0, 0, 0, 0, 0, 18, 768, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Akali - On Spellhit \'Submission\' - Set Flags Immune To Players & Immune To NPC\'s'),
(28952, 0, 3, 0, 61, 0, 100, 512, 0, 0, 0, 0, 0, 0, 69, 1, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 6829.59, -4525.52, 442.068, 0, 'Akali - On Spellhit \'Submission\' - Move To Position'),
(28952, 0, 4, 0, 34, 0, 100, 512, 0, 1, 0, 0, 0, 0, 80, 2895201, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Akali - On Reached Point 1 - Run Quest End Script'),
(28952, 0, 5, 0, 9, 0, 100, 0, 0, 0, 10000, 10000, 0, 80, 11, 52856, 0, 0, 0, 0, 0, 6, 0, 0, 0, 0, 0, 0, 0, 0, 'Akali - Within 0-80 Range - Cast \'Charge\''),
(28952, 0, 6, 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 80, 2895202, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Akali - On Respawn - Run Quest Reset Script'),
(28952, 0, 7, 0, 72, 0, 100, 0, 11, 0, 0, 0, 0, 0, 63, 1, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Akali - On Action 11 Done: Paw Freed - Add 1 to Broken Chains Counter');

-- === ACTION LISTS ===
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2895200, 9, 0, 0, 0, 0, 100, 0, 2000, 2000, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Akali - Quest Success Script - Say Line 0'),
(2895200, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 15, 12721, 0, 0, 0, 0, 0, 18, 60, 0, 0, 0, 0, 0, 0, 0, 'Akali - Quest Success Script - Quest Credit \'Rampage\''),
(2895200, 9, 2, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 107, 1, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Akali - Quest Success Script - Summon Creature Group 1'),
(2895200, 9, 3, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 92, 0, 45579, 0, 0, 0, 0, 9, 28988, 0, 100, 0, 0, 0, 0, 0, 'Akali - Actionlist - Interrupt Spell \'Fire Channeling\''),
(2895200, 9, 4, 0, 0, 0, 100, 0, 4600, 4600, 0, 0, 0, 0, 19, 768, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Akali - Quest Success Script - Remove Flag Immune To NPC\'s'),
(2895200, 9, 5, 0, 0, 0, 100, 0, 55000, 55000, 0, 0, 0, 0, 12, 28996, 8, 0, 0, 0, 0, 8, 0, 0, 0, 0, 6882.03, -4571, 442.312, 2.37365, 'Akali - Quest Success Script - Summon Creature \'Prophet of Akali\'');

INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2895201, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 2, 35, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Akali - Quest End Script - Set Faction 35'),
(2895201, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 24, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Akali - Quest End Script - Evade'),
(2895201, 9, 2, 0, 0, 0, 100, 0, 200, 200, 0, 0, 0, 0, 66, 0, 0, 0, 0, 0, 0, 19, 28996, 100, 0, 0, 0, 0, 0, 0, 'Akali - Quest End Script - Set Orientation Closest Creature \'Prophet of Akali\''),
(2895201, 9, 3, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 45, 0, 1, 0, 0, 0, 0, 19, 28996, 100, 0, 0, 0, 0, 0, 0, 'Akali - Quest End Script - Set Data 0 1');

INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2895202, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 18, 768, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Akali - Reset Script - Set Flags Immune To Players & Immune To NPC\'s'),
(2895202, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 2, 1770, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Akali - Reset Script - Set Faction 1770'),
(2895202, 9, 2, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 223, 10, 0, 0, 0, 0, 0, 9, 0, 0, 100, 0, 0, 0, 0, 0, 'Akali - Reset Script - Do Action ID 10: Relay Reset to All Creatures in 100yd'),
(2895202, 9, 3, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 102, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Akali - Actionlist - Set Health Regeneration Off'),
(2895202, 9, 4, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 63, 1, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Akali - Actionlist - Reset Counter');

-- === AKALI SUBDUER (entry 28988) ===
-- id=1000: intentionally high to avoid colliding with entry-based combat scripts (ids 0-999)
-- that may exist on entry 28988 in the DB. GUID-specific rows here add only the reset relay.
UPDATE `creature_template` SET `flags_extra` = `flags_extra`|134217728 WHERE (`entry` = 28988);

INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(-101661, 0, 1000, 0, 72, 0, 100, 0, 10, 0, 0, 0, 0, 0, 11, 45579, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Akali Subduer - On Action 10 Done - Cast \'Fire Channeling\''),
(-101662, 0, 1000, 0, 72, 0, 100, 0, 10, 0, 0, 0, 0, 0, 11, 45579, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Akali Subduer - On Action 10 Done - Cast \'Fire Channeling\''),
(-101663, 0, 1000, 0, 72, 0, 100, 0, 10, 0, 0, 0, 0, 0, 11, 45579, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Akali Subduer - On Action 10 Done - Cast \'Fire Channeling\''),
(-101665, 0, 1000, 0, 72, 0, 100, 0, 10, 0, 0, 0, 0, 0, 11, 45579, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Akali Subduer - On Action 10 Done - Cast \'Fire Channeling\''),
(-101666, 0, 1000, 0, 72, 0, 100, 0, 10, 0, 0, 0, 0, 0, 11, 45579, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Akali Subduer - On Action 10 Done - Cast \'Fire Channeling\''),
(-101667, 0, 1000, 0, 72, 0, 100, 0, 10, 0, 0, 0, 0, 0, 11, 45579, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Akali Subduer - On Action 10 Done - Cast \'Fire Channeling\''),
(-101668, 0, 1000, 0, 72, 0, 100, 0, 10, 0, 0, 0, 0, 0, 11, 45579, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Akali Subduer - On Action 10 Done - Cast \'Fire Channeling\''),
(-101669, 0, 1000, 0, 72, 0, 100, 0, 10, 0, 0, 0, 0, 0, 11, 45579, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Akali Subduer - On Action 10 Done - Cast \'Fire Channeling\''),
(-203572, 0, 1000, 0, 72, 0, 100, 0, 10, 0, 0, 0, 0, 0, 11, 45579, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Akali Subduer - On Action 10 Done - Cast \'Fire Channeling\''),
(-203573, 0, 1000, 0, 72, 0, 100, 0, 10, 0, 0, 0, 0, 0, 11, 45579, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Akali Subduer - On Action 10 Done - Cast \'Fire Channeling\''),
(-203574, 0, 1000, 0, 72, 0, 100, 0, 10, 0, 0, 0, 0, 0, 11, 45579, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Akali Subduer - On Action 10 Done - Cast \'Fire Channeling\''),
(-203575, 0, 1000, 0, 72, 0, 100, 0, 10, 0, 0, 0, 0, 0, 11, 45579, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Akali Subduer - On Action 10 Done - Cast \'Fire Channeling\''),
(-203576, 0, 1000, 0, 72, 0, 100, 0, 10, 0, 0, 0, 0, 0, 11, 45579, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Akali Subduer - On Action 10 Done - Cast \'Fire Channeling\''),
(-203577, 0, 1000, 0, 72, 0, 100, 0, 10, 0, 0, 0, 0, 0, 11, 45579, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Akali Subduer - On Action 10 Done - Cast \'Fire Channeling\'');
