-- DB update 2025_12_16_02 -> 2025_12_17_00
--
-- Faerie Fire group
-- SPELL_GROUP_STACK_RULE_EXCLUSIVE_SAME_EFFECT	'Same effects of spells will not stack, yet auras will remain on a target'
UPDATE `spell_group_stack_rules` SET `stack_rule`=3 WHERE `group_id`=1016;
