-- DB update 2026_05_06_00 -> 2026_05_07_00
DELETE FROM `spell_linked_spell` WHERE `spell_trigger` = -48323;
INSERT INTO `spell_linked_spell` (`spell_trigger`, `spell_effect`, `type`, `comment`) VALUES
(-48323, 48330, 0, 'On Indisposed Expiring - Cast Create Amberseeds');
