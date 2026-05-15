-- DB update 2026_05_14_00 -> 2026_05_15_00
-- Remove trigger bunny SAI scripts that interfere with the chain mechanic
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` IN (-113478, -113479, -113550, -113551));

-- === CHAIN BUNNIES: add On Spawn event (id=0) so chains arm immediately on spawn ===
-- Phase 1 = chain intact and ready to be broken; Phase 0 = chain broken
-- id=0: SPAWN       -> CAST chain spell, link=1
-- id=1: LINK        -> SET PHASE 1
-- id=2: ACTION(10)  -> CAST chain spell, link=1 (Akali reset: re-arm)
-- id=3: SPELLHIT(52816), phase=1, flags=512 -> REMOVE_AURA from trigger bunny, link=4
-- id=4: LINK, phase=1 -> DO_ACTION(11) on Akali, link=5
-- id=5: LINK        -> SET PHASE 0

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` IN (-113549, -113548, -61994, -61995));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
-- Right Front Paw  GUID -113549 / chain spell 52834 / trigger bunny 113551
(-113549, 0, 0, 1, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 52834, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'ELM General Purpose Bunny (scale x0.01) Large - On Spawn: Cast \'Rampage: Akali`s Chains - Right Front Paw\''),
(-113549, 0, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 22, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'ELM General Purpose Bunny (scale x0.01) Large - On Spawn/Reset: Set Event Phase 1'),
(-113549, 0, 2, 1, 72, 0, 100, 0, 10, 0, 0, 0, 0, 0, 11, 52834, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'ELM General Purpose Bunny (scale x0.01) Large - On Action 10 (Reset): Cast \'Rampage: Akali`s Chains - Right Front Paw\''),
(-113549, 0, 3, 4, 8, 1, 100, 512, 52816, 0, 0, 0, 0, 0, 28, 52834, 0, 0, 0, 0, 0, 10, 113551, 26298, 0, 0, 0, 0, 0, 0, 'ELM General Purpose Bunny (scale x0.01) Large - On Spellhit \'Rampage: Akali Chain Anchor On Disturb\': Remove Aura \'Rampage: Akali`s Chains - Right Front Paw\''),
(-113549, 0, 4, 5, 61, 1, 100, 0, 0, 0, 0, 0, 0, 0, 223, 11, 0, 0, 0, 0, 0, 10, 98159, 28952, 0, 0, 0, 0, 0, 0, 'ELM General Purpose Bunny (scale x0.01) Large - On Spellhit \'Rampage: Akali Chain Anchor On Disturb\': Do Action 11 On Akali - Right Front Paw Freed'),
(-113549, 0, 5, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 22, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'ELM General Purpose Bunny (scale x0.01) Large - On Spellhit \'Rampage: Akali Chain Anchor On Disturb\': Set Event Phase 0'),
-- Left Front Paw  GUID -113548 / chain spell 52833 / trigger bunny 113550
(-113548, 0, 0, 1, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 52833, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'ELM General Purpose Bunny (scale x0.01) Large - On Spawn: Cast \'Rampage: Akali`s Chains - Left Front Paw\''),
(-113548, 0, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 22, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'ELM General Purpose Bunny (scale x0.01) Large - On Spawn/Reset: Set Event Phase 1'),
(-113548, 0, 2, 1, 72, 0, 100, 0, 10, 0, 0, 0, 0, 0, 11, 52833, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'ELM General Purpose Bunny (scale x0.01) Large - On Action 10 (Reset): Cast \'Rampage: Akali`s Chains - Left Front Paw\''),
(-113548, 0, 3, 4, 8, 1, 100, 512, 52816, 0, 0, 0, 0, 0, 28, 52833, 0, 0, 0, 0, 0, 10, 113550, 26298, 0, 0, 0, 0, 0, 0, 'ELM General Purpose Bunny (scale x0.01) Large - On Spellhit \'Rampage: Akali Chain Anchor On Disturb\': Remove Aura \'Rampage: Akali`s Chains - Left Front Paw\''),
(-113548, 0, 4, 5, 61, 1, 100, 0, 0, 0, 0, 0, 0, 0, 223, 11, 0, 0, 0, 0, 0, 10, 98159, 28952, 0, 0, 0, 0, 0, 0, 'ELM General Purpose Bunny (scale x0.01) Large - On Spellhit \'Rampage: Akali Chain Anchor On Disturb\': Do Action 11 On Akali - Left Front Paw Freed'),
(-113548, 0, 5, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 22, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'ELM General Purpose Bunny (scale x0.01) Large - On Spellhit \'Rampage: Akali Chain Anchor On Disturb\': Set Event Phase 0'),
-- Right Rear Paw  GUID -61994 / chain spell 52837 / trigger bunny 113478
(-61994, 0, 0, 1, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 52837, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'ELM General Purpose Bunny (scale x0.01) Large - On Spawn: Cast \'Rampage: Akali`s Chains - Right Rear Paw\''),
(-61994, 0, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 22, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'ELM General Purpose Bunny (scale x0.01) Large - On Spawn/Reset: Set Event Phase 1'),
(-61994, 0, 2, 1, 72, 0, 100, 0, 10, 0, 0, 0, 0, 0, 11, 52837, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'ELM General Purpose Bunny (scale x0.01) Large - On Action 10 (Reset): Cast \'Rampage: Akali`s Chains - Right Rear Paw\''),
(-61994, 0, 3, 4, 8, 1, 100, 512, 52816, 0, 0, 0, 0, 0, 28, 52837, 0, 0, 0, 0, 0, 10, 113478, 26298, 0, 0, 0, 0, 0, 0, 'ELM General Purpose Bunny (scale x0.01) Large - On Spellhit \'Rampage: Akali Chain Anchor On Disturb\': Remove Aura \'Rampage: Akali`s Chains - Right Rear Paw\''),
(-61994, 0, 4, 5, 61, 1, 100, 0, 0, 0, 0, 0, 0, 0, 223, 11, 0, 0, 0, 0, 0, 10, 98159, 28952, 0, 0, 0, 0, 0, 0, 'ELM General Purpose Bunny (scale x0.01) Large - On Spellhit \'Rampage: Akali Chain Anchor On Disturb\': Do Action 11 On Akali - Right Rear Paw Freed'),
(-61994, 0, 5, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 22, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'ELM General Purpose Bunny (scale x0.01) Large - On Spellhit \'Rampage: Akali Chain Anchor On Disturb\': Set Event Phase 0'),
-- Left Rear Paw  GUID -61995 / chain spell 52838 / trigger bunny 113479
(-61995, 0, 0, 1, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 52838, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'ELM General Purpose Bunny (scale x0.01) Large - On Spawn: Cast \'Rampage: Akali`s Chains - Left Rear Paw\''),
(-61995, 0, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 22, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'ELM General Purpose Bunny (scale x0.01) Large - On Spawn/Reset: Set Event Phase 1'),
(-61995, 0, 2, 1, 72, 0, 100, 0, 10, 0, 0, 0, 0, 0, 11, 52838, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'ELM General Purpose Bunny (scale x0.01) Large - On Action 10 (Reset): Cast \'Rampage: Akali`s Chains - Left Rear Paw\''),
(-61995, 0, 3, 4, 8, 1, 100, 512, 52816, 0, 0, 0, 0, 0, 28, 52838, 0, 0, 0, 0, 0, 10, 113479, 26298, 0, 0, 0, 0, 0, 0, 'ELM General Purpose Bunny (scale x0.01) Large - On Spellhit \'Rampage: Akali Chain Anchor On Disturb\': Remove Aura \'Rampage: Akali`s Chains - Left Rear Paw\''),
(-61995, 0, 4, 5, 61, 1, 100, 0, 0, 0, 0, 0, 0, 0, 223, 11, 0, 0, 0, 0, 0, 10, 98159, 28952, 0, 0, 0, 0, 0, 0, 'ELM General Purpose Bunny (scale x0.01) Large - On Spellhit \'Rampage: Akali Chain Anchor On Disturb\': Do Action 11 On Akali - Left Rear Paw Freed'),
(-61995, 0, 5, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 22, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'ELM General Purpose Bunny (scale x0.01) Large - On Spellhit \'Rampage: Akali Chain Anchor On Disturb\': Set Event Phase 0');

-- === FIRE BUNNIES: add On Spawn cast so fire visual appears immediately on spawn ===
-- id=0: SPAWN       -> CAST fire aura on self
-- id=1: ACTION(10)  -> CAST fire aura on self (Akali reset relay)
-- id=2: SPELLHIT(52816), flags=512 -> REMOVE_AURA fire aura from self

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` IN (-100336, -100333, -100335, -100334));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
-- Right Front Fire  GUID -100336
(-100336, 0, 0, 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 52855, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'ELM General Purpose Bunny Large - On Spawn: Cast \'Cosmetic - Low Poly Fire (with Sound)\''),
(-100336, 0, 1, 0, 72, 0, 100, 0, 10, 0, 0, 0, 0, 0, 11, 52855, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'ELM General Purpose Bunny Large - On Action 10 (Reset): Cast \'Cosmetic - Low Poly Fire (with Sound)\''),
(-100336, 0, 2, 0, 8, 0, 100, 512, 52816, 0, 0, 0, 0, 0, 28, 52855, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'ELM General Purpose Bunny Large - On Spellhit \'Rampage: Akali Chain Anchor On Disturb\': Remove Aura \'Cosmetic - Low Poly Fire (with Sound)\''),
-- Left Front Fire  GUID -100333
(-100333, 0, 0, 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 52855, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'ELM General Purpose Bunny Large - On Spawn: Cast \'Cosmetic - Low Poly Fire (with Sound)\''),
(-100333, 0, 1, 0, 72, 0, 100, 0, 10, 0, 0, 0, 0, 0, 11, 52855, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'ELM General Purpose Bunny Large - On Action 10 (Reset): Cast \'Cosmetic - Low Poly Fire (with Sound)\''),
(-100333, 0, 2, 0, 8, 0, 100, 512, 52816, 0, 0, 0, 0, 0, 28, 52855, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'ELM General Purpose Bunny Large - On Spellhit \'Rampage: Akali Chain Anchor On Disturb\': Remove Aura \'Cosmetic - Low Poly Fire (with Sound)\''),
-- Right Rear Fire  GUID -100335
(-100335, 0, 0, 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 52855, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'ELM General Purpose Bunny Large - On Spawn: Cast \'Cosmetic - Low Poly Fire (with Sound)\''),
(-100335, 0, 1, 0, 72, 0, 100, 0, 10, 0, 0, 0, 0, 0, 11, 52855, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'ELM General Purpose Bunny Large - On Action 10 (Reset): Cast \'Cosmetic - Low Poly Fire (with Sound)\''),
(-100335, 0, 2, 0, 8, 0, 100, 512, 52816, 0, 0, 0, 0, 0, 28, 52855, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'ELM General Purpose Bunny Large - On Spellhit \'Rampage: Akali Chain Anchor On Disturb\': Remove Aura \'Cosmetic - Low Poly Fire (with Sound)\''),
-- Left Rear Fire  GUID -100334
(-100334, 0, 0, 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 52855, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'ELM General Purpose Bunny Large - On Spawn: Cast \'Cosmetic - Low Poly Fire (with Sound)\''),
(-100334, 0, 1, 0, 72, 0, 100, 0, 10, 0, 0, 0, 0, 0, 11, 52855, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'ELM General Purpose Bunny Large - On Action 10 (Reset): Cast \'Cosmetic - Low Poly Fire (with Sound)\''),
(-100334, 0, 2, 0, 8, 0, 100, 512, 52816, 0, 0, 0, 0, 0, 28, 52855, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'ELM General Purpose Bunny Large - On Spellhit \'Rampage: Akali Chain Anchor On Disturb\': Remove Aura \'Cosmetic - Low Poly Fire (with Sound)\'');

-- Fix comment on Akali Reset Script relay action
UPDATE `smart_scripts` SET `comment` = 'Akali - Reset Script - Do Action ID 10: Relay Reset to All Creatures in 100yd' WHERE (`source_type` = 9 AND `entryorguid` = 2895202 AND `id` = 2);
