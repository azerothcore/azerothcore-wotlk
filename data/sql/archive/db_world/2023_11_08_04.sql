-- DB update 2023_11_08_03 -> 2023_11_08_04
-- Bloodburn
DELETE FROM `spell_custom_attr` WHERE `spell_id`=34856;
INSERT INTO `spell_custom_attr` (`spell_id`, `attributes`) VALUES (34856, 4194304);
