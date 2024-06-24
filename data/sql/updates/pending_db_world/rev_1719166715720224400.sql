-- 16606 'Midsummer Bonfire Despawner'
-- add TRIGGER flag
UPDATE `creature_template` SET `flags_extra` = (`flags_extra` | 128) WHERE (`entry` = 16606);
-- Script
UPDATE `creature_template` SET `ScriptName` = 'npc_midsummer_bonfire_despawner' WHERE (`entry` = 16606);
