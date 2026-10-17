-- DB update 2025_12_20_00 -> 2025_12_20_01
--
-- Temporary Haste Buffs (PI, Heroism, Bloodlust)
-- 3	SPELL_GROUP_STACK_RULE_EXCLUSIVE_SAME_EFFECT	Same effects of spells will not stack, yet auras will remain on a target
UPDATE `spell_group_stack_rules` SET `stack_rule`=3 WHERE `group_id`=1122;
-- Power Infusion and Arcane Power
-- 4	SPELL_GROUP_STACK_RULE_EXCLUSIVE_HIGHEST	Only Highest effect will remain on target
UPDATE `spell_group_stack_rules` SET `stack_rule`=4 WHERE `group_id`=1123;
