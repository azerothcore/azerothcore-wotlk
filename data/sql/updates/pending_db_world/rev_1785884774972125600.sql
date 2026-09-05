--
-- The four Warbringer Constructs in the Black Vault's Relic Coffer room must not
-- re-apply Stoned (10255) from creature_addon on every evade (CreatureAI::_EnterEvadeMode
-- reloads addon auras), or they would re-freeze after the vault event has started.
-- The instance script casts the aura once on spawn instead.
UPDATE `creature_addon` SET `auras` = '' WHERE `guid` IN (46608, 46610, 46611, 46612);
