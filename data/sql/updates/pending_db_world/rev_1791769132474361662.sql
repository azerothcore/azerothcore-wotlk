--
-- Illidan Stormrage - Demon Fire: overlapping emitters hit a target only once per tick
DELETE FROM `spell_custom_attr` WHERE `spell_id` = 40030;
INSERT INTO `spell_custom_attr` (`spell_id`, `attributes`) VALUES (40030, 0x20000000);
