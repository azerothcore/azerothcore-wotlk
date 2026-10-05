--
-- Kologarn, Arm Dead Damage: SPELL_ATTR0_CU_IGNORE_ARMOR
DELETE FROM `spell_custom_attr` WHERE `spell_id` IN (63629, 63979);
INSERT INTO `spell_custom_attr` (`spell_id`, `attributes`) VALUES
(63629, 32768),
(63979, 32768);
