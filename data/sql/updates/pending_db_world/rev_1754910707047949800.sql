--
-- Anub'ar Venomancer - Poison Bolt, Poison Bolt(H)
DELETE FROM `spell_custom_attr` WHERE `spell_id` IN (53617, 59359);

INSERT INTO `spell_custom_attr` (`spell_id`, `attributes`) VALUES (53617, 4194304);
INSERT INTO `spell_custom_attr` (`spell_id`, `attributes`) VALUES (59359, 4194304);


