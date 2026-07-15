-- DB update 2026_07_15_00 -> 2026_07_15_01
-- Watcher Gashra's Enrage (52470) is a self-buff, but its -50% physical damage
-- done effect (EFFECT_2) makes the core classify the whole aura as negative,
-- so it shows as a debuff on the target frame.
-- Mark all three effects positive (SPELL_ATTR0_CU_POSITIVE_EFF0 | EFF1 | EFF2).
DELETE FROM `spell_custom_attr` WHERE `spell_id` = 52470;
INSERT INTO `spell_custom_attr` (`spell_id`, `attributes`) VALUES (52470, 0x0E000000);
