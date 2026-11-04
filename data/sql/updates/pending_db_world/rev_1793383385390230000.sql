--
-- Rising Anger (Gormok): SPELL_ATTR0_CU_SINGLE_AURA_STACK, so every Snobold's cast stacks on one aura
DELETE FROM `spell_custom_attr` WHERE `spell_id` = 66636;
INSERT INTO `spell_custom_attr` (`spell_id`, `attributes`) VALUES
(66636, 4194304);
