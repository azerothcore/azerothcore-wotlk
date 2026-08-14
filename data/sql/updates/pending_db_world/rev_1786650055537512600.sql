-- Professor Putricide - Gas Cloud (37562): Expunged Gas contact detonation.
-- Gaseous Bloat must proc only on the Gas Cloud's melee auto attack on its fixated
-- target, never on its own damage ticks. The DBC ProcFlags cannot be relied on, so
-- pin them here for all four difficulty variants.
UPDATE `spell_proc` SET `ProcFlags` = 8 WHERE `SpellId` IN (70672, 72455, 72832, 72833);

-- Expunged Gas (70701) reaches the whole raid and its damage is divided among the
-- players hit, exactly like Ooze Eruption (70492) in the same encounter.
DELETE FROM `spell_custom_attr` WHERE `spell_id` = 70701;
INSERT INTO `spell_custom_attr` (`spell_id`, `attributes`) VALUES
(70701, 8);
