-- DB update 2026_11_23_02 -> 2026_11_23_03
--
-- Well Fed (DND) is applied by its visible Well Fed (66623) through spell_linked_spell; sharing the exclusive
-- Well Fed group made it remove 66623 right away, so the Bountiful Feast left no visible buff.
DELETE FROM `spell_group` WHERE `id` = 1001 AND `spell_id` = 66624;
