-- General Vezax - Shadow Crash (63277): only one puddle area aura may affect a target (#27226, #26927)
DELETE FROM `spell_custom_attr` WHERE `spell_id` = 63277;
INSERT INTO `spell_custom_attr` (`spell_id`, `attributes`) VALUES
(63277, 536870912); -- SPELL_ATTR0_CU_ONLY_ONE_AREA_AURA
