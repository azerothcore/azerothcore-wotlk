-- DB update 2022_11_04_00 -> 2022_11_04_01
--
UPDATE `quest_template_addon` SET `SpecialFlags` = `SpecialFlags`|1 WHERE `id` IN (8789, 8790);
