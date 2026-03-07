-- DB update 2026_03_01_06 -> 2026_03_01_07
-- Fix Missile Barrage / Clearcasting proc interaction with Arcane Missiles
-- 1) PROC_ATTR_REQ_SPELLMOD was incorrectly blocking Missile Barrage from
--    proccing because the channel spell (42846) is not in m_appliedMods.
--    Restrict via SpellFamilyMask to Arcane Missiles (0x800) instead.
-- 2) Register Clearcasting script to give Missile Barrage priority
UPDATE `spell_proc` SET `AttributesMask` = 0, `SpellFamilyMask0` = 0x800 WHERE `SpellId` = 44401;

DELETE FROM `spell_script_names` WHERE `spell_id` = 12536 AND `ScriptName` = 'spell_mage_clearcasting';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES (12536, 'spell_mage_clearcasting');
