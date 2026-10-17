-- DB update 2025_05_23_06 -> 2025_05_24_00
--
DELETE FROM `spell_linked_spell` WHERE `spell_trigger`=45848 AND `spell_effect`=47314;
INSERT INTO `spell_linked_spell` (`spell_trigger`, `spell_effect`, `type`, `comment`) VALUES (45848, 47314, 0, 'Shield of the Blue 95% output damage reduction');
