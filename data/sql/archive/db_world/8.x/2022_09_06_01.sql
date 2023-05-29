-- DB update 2022_09_06_00 -> 2022_09_06_01
--
UPDATE `quest_template_addon` SET `SpecialFlags` = `SpecialFlags`|1 WHERE `id` IN (8543, 8546);
