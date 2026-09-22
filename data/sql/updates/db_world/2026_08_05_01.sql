-- DB update 2026_08_05_00 -> 2026_08_05_01

-- Add SPELL_ATTR0_CU_ALLOW_INFLIGHT_TARGET
DELETE FROM `spell_custom_attr` WHERE `spell_id` = 43419;
INSERT INTO `spell_custom_attr` (`spell_id`, `attributes`) VALUES
(43419, 262144);
