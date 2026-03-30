-- DB update 2025_04_10_01 -> 2025_04_11_00
--
-- set Spell Fury Effect 2 (SPELL_AURA_MOD_ROOT) as Positive (SPELL_ATTR0_CU_POSITIVE_EFF2)
DELETE FROM `spell_custom_attr` WHERE `spell_id` = 46102;
INSERT INTO `spell_custom_attr` (`spell_id`, `attributes`) VALUES(46102, 134217728);
