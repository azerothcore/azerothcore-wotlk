-- DB update 2023_10_17_05 -> 2023_10_17_06
-- Ravenous Windroc
UPDATE `smart_scripts` SET `action_param2` = 0 WHERE `entryorguid` = 18220 AND `source_type` = 0 AND `id` = 0;

DELETE FROM `spell_custom_attr` WHERE `spell_id`=30285;
INSERT INTO `spell_custom_attr` (`spell_id`, `attributes`) VALUES (30285, 4194304);
