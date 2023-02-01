-- DB update 2022_09_06_01 -> 2022_09_06_02
--
UPDATE `quest_template_addon` SET `SpecialFlags` = `SpecialFlags`|1 WHERE `id`=8495;
