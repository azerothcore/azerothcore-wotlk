-- DB update 2024_02_13_00 -> 2024_02_13_01
-- disables buff stacking for items 49856, 49857, 49858, 49859, 49861, 49860

-- making sure group is free
DELETE FROM `spell_group`
       WHERE `id` = 1035
         AND `spell_id` IN (70233, 70234, 70235, 70242, 70243, 70244);

-- inserting spell_id's for the group
INSERT INTO `spell_group` (`id`, `spell_id`, `special_flag`)
VALUES
(1035, 70233, 16),
(1035, 70234, 16),
(1035, 70235, 16),
(1035, 70242, 16),
(1035, 70243, 16),
(1035, 70244, 16);
