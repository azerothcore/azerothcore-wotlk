-- DB update 2026_02_23_05 -> 2026_02_23_06
-- Fix spell_script_names for spell_hun_rapid_recuperation
-- Script was moved from talent (53228/53232) to periodic mana aura (56654/58882)
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'spell_hun_rapid_recuperation';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(56654, 'spell_hun_rapid_recuperation'),
(58882, 'spell_hun_rapid_recuperation');

-- Remove explicit Inner Focus spell_proc entry (now auto-generated with PROC_ATTR_REQ_SPELLMOD)
DELETE FROM `spell_proc` WHERE `SpellId` = 14751;
