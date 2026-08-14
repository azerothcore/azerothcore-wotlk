-- Professor Putricide - Gas Cloud (37562): Expunged Gas contact detonation.
-- Expunged Gas (70701) reaches the whole raid and its damage is divided among the
-- players hit, exactly like Ooze Eruption (70492) in the same encounter.
DELETE FROM `spell_custom_attr` WHERE `spell_id` = 70701;
INSERT INTO `spell_custom_attr` (`spell_id`, `attributes`) VALUES
(70701, 8);
