-- DB update 2026_06_14_00 -> 2026_06_14_01
--
-- Fix Deep Freeze: only proc trigger spell 71757 on permanently stun-immune creatures
DELETE FROM `spell_script_names` WHERE `spell_id`=71761;
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES (71761, 'spell_mage_deep_freeze_immunity_state');
